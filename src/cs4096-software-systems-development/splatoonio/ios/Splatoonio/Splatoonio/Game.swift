import Foundation
import CoreLocation


class Game : NSObject
{
	// check our update queue, and if there happen to be updates for the future, only apply them when that time comes
	private static let UPDATE_INTERVAL:TimeInterval = 0.2		// process updateQueue updates every this many seconds
	private static let DIFF_INTERVAL:TimeInterval = 1.0			// query the server for diffs every this many seconds
	
	var id:GameID
	var me:Player?			// nil-able because we can work with a game that we aren't in (i.e. replays/spectating)
	var board:GameBoard
	var players:[PlayerID:Player]
	var items:[Item]
	var delegate:GameDelegate?
	
	// public only for ServerAPI access when making requests
	var diffState:Int							// what the game state is from the last diff
	var serverTime:TimeInterval					// number of seconds into the game
	
	private var startTime:TimeInterval!			// when the game starts/started; offset from 1970
	private var endTime:TimeInterval!			// when the game ends/ended; offset from 1970
	private var diffTimer:Timer?				// kick off diff queries every DIFF_INTERVAL seconds
	private var updateTimer:Timer?				// process updates every UPDATE_INTERVAL seconds
	private var updateQueue:PriorityQueue<TileUpdate>		// allows playing replays/games (collection of updates) without a server
	
	// updates get added on a background thread via server web requests, but it gets polled on the
	// main thread, so we need some updateQueue safety syncing
	private var updateQueueLock:NSLock!
	
	// =================================================================================
	//									Initializiers
	// =================================================================================
	
	override init()
	{
		id = 0
		me = nil
		board = GameBoard()
		players = [PlayerID:Player]()
		items = [Item]()
		delegate = nil
		
		diffState = -1
		
		serverTime = 0
		startTime = nil
		diffTimer = nil
		updateTimer = nil
		updateQueue = PriorityQueue<TileUpdate>()
		updateQueueLock = NSLock()
	}
	
	// =================================================================================
	
	init?(_ json:[String:Any])
	{
		guard let current = json["server_clock"] as? TimeInterval else { return nil }
		guard let start = json["start"] as? TimeInterval else { return nil }
		guard let end = json["end"] as? TimeInterval else { return nil }
		guard let mapString = json["map"] as? String else { return nil }
		guard let mapID = MapID(mapString) else { return nil }
		guard let gameIDString = json["game"] as? String else { return nil }
		guard let gameID = GameID(gameIDString) else { return nil }
		
		id = gameID
		serverTime = 0
		me = nil
		board = GameBoard()
		players = [PlayerID:Player]()
		items = [Item]()
		delegate = nil
		
		diffState = -1
		
		serverTime = current
		startTime = start
		endTime = end
		diffTimer = nil
		updateTimer = nil
		updateQueue = PriorityQueue<TileUpdate>()
		updateQueueLock = NSLock()
		
		super.init()

		self.load(id:mapID)
	}

	// =================================================================================
	// Demo-only initializer. Skips the server round-trip by letting the caller
	// supply a pre-built Map; used by the offline screenshots flow in ServerAPI.
	convenience init(demoMap:Map, gameID:GameID = 1, duration:TimeInterval = 600)
	{
		self.init()
		let now = Date().timeIntervalSince1970
		self.id = gameID
		self.board = GameBoard(demoMap)
		self.serverTime = 0
		self.startTime = now
		self.endTime = now + duration
	}

	// =================================================================================
	//										Loading
	// =================================================================================
	
	func load(id mapID:MapID)
	{
		// TODO: figure out some way to let the user know if this fails
		ServerAPI.map(for:mapID, onComplete:self.setMap)
	}
	
	// =================================================================================
	
	func setMap(_ m:Map?, error:Error?)
	{
		guard let map = m else { return }
		board = GameBoard(map)
		
		// get the initial board from the server
		ServerAPI.getDiff(self, entireState:true)
	}
	
	// =================================================================================
	//									Game Lifecycle
	// =================================================================================
	
	func startGame()
	{
		print("STATUS: starting game")
		if (startTime == nil)
		{
			startTime = Date().timeIntervalSince1970
		}
		
		// get board updates periodically
		updateQueueLock.lock()
		updateQueue.clear(keepingCapacity:true)
		updateQueueLock.unlock()
		
		self.diffTimer = Timer.scheduledTimer(timeInterval:Game.DIFF_INTERVAL,
		                                      target:self,
		                                      selector:#selector(self.getDiff(_:)),
		                                      userInfo:nil,
		                                      repeats:true)
		self.updateTimer = Timer.scheduledTimer(timeInterval:Game.UPDATE_INTERVAL,
		                                        target:self,
		                                        selector:#selector(self.processUpdates(_:)),
		                                        userInfo:nil,
		                                        repeats:true)
	}
	
	// =================================================================================
	
	@objc func processUpdates(_:Timer)
	{
		updateQueueLock.lock()
		var updates = [TileUpdate]()
		
		while let time = updateQueue.peek()?.timestamp, (time < serverTime)
		{
			// we can force unwrap the polled value because it has to be non-nil for the while condition to be true
			updates.append(updateQueue.poll()!)
		}
		updateQueueLock.unlock()
		
		updates = board.update(tiles:updates)
		delegate?.boardUpdated(tiles:updates)
		
		if (serverTime > endTime)
		{
			print("STATUS: Game over")
			endGame()
			delegate?.gameOver(won:true)
		}
	}
	
	// =================================================================================
	
	@objc func getDiff(_:Timer)
	{
		ServerAPI.getDiff(self, entireState:false)
	}
	
	// =================================================================================
	// clean up game stuff
	func endGame()
	{
		// TODO: implement - what else is there to do?
		diffTimer?.invalidate()
		updateTimer?.invalidate()
	}
	
	// =================================================================================
	
	func quit()
	{
		endGame()
	}
	
	// =================================================================================
	//									Game Interaction
	// =================================================================================
	// player - The player to add to the game
	// me - Pass true to designate player as us
	// Returns player if the given player is not in the game, else returns the player in
	// the game with the same player ID as the given player.
	@discardableResult func addPlayer(player:Player, isMe:Bool) -> Player
	{
		// check if player is already playing (don't add the same player twice)
		for (id, p) in players
		{
			if (id == player.id)
			{
				// allow updating which player we are
				if (isMe)
				{
					me = p
				}
				
				return p
			}
		}
		
		// We only get here if player is not in the game
		players[player.id] = player
		
		if (isMe)
		{
			me = player
		}
		
		return player
	}
	
	// =================================================================================
	
	func move(player pid:PlayerID, to location:CLLocation)
	{
		// check that the player is valid
		guard let player = players[pid] else { return }
		var updatedTiles:[TileUpdate]
		
		if let oldLoc = player.location, (oldLoc.coordinate != location.coordinate)
		{
			let travelTime = location.timestamp.timeIntervalSince(oldLoc.timestamp)
			updatedTiles = board.paintLine(from:oldLoc.coordinate, to:location.coordinate, travelTime:travelTime, forPlayer:player)
		}
		else
		{
			updatedTiles = board.paintPoint(at:location.coordinate, forPlayer:player)
		}
		
		// if we actually changed anything, let everything know
		if (updatedTiles.count > 0)
		{
			let updatedTiles = board.update(tiles:updatedTiles)
			
			// notify the server if this was us
			if (pid == me?.id)
			{
				ServerAPI.updateGame(self, with:updatedTiles)
			}
		}
		
		player.location = location
	}
	
	// =================================================================================
	
	func addUpdates(updates:[TileUpdate])
	{
		updateQueueLock.lock()
		
		for update in updates
		{
			updateQueue.add(update)
		}
		
		updateQueueLock.unlock()
	}
	
	// =================================================================================	
}
