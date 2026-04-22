import Foundation
import MapKit
import CoreLocation

enum ServerError: Error
{
    case unexpectedStatusCode(String)
	case invalidResponseData(String)
	case connectionError(String)			// if the request sends back a non-nil error
	case processingError(String)			// something went wrong not related to client-sever communications
}


// TODO: maybe needs to be an actual object if we need to manage connection information?
// Maybe make connection information static (we should never be talking to more than one server)?
class ServerAPI
{
//	static let BASE_URL = "http://localhost:8000/api"			// use for simulator
	static let BASE_URL = "http://159.203.116.24:8000/api"		// Digital Ocean (long-dead; ignored when AppData.DEMO_MODE == true)
	
    enum StatusCodes
	{
        case success, failure
    }
    
    // =================================================================================
    //                       User/Account Management (Login Stuff)
	// =================================================================================
	
	static func createAccount(username:String, password:String, onComplete:@escaping (ServerError?) -> Void)
	{
		// do url REST stuff
		guard var request = getRequest(method:"POST", endpoint:"/users") else { return }
		
		let json = "{\"username\":\"\(username)\", \"password\":\"\(password)\"}"
		request.httpBody = json.data(using:.ascii)
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.createAccount()")
			{
				onComplete(e)
				return
			}
			
			guard let dict = data?.asDictionary(),
				let sessionKey = dict["session_key"] as? String,
				let userid = dict["user_id"] as? UserID else
			{
				onComplete(ServerError.processingError("ServerAPI.createAccount(): Could not parse session key from response"))
				return
			}
			
			AppData.currentUser = User()
			AppData.currentUser!.ID = userid
			AppData.currentUser!.session = sessionKey
			onComplete(nil)
		})
		task.resume()
	}
	
    // =================================================================================
	
	static func logoutUser(onComplete: @escaping(ServerError?) -> Void)
	{
        guard let request = getRequest(method:"DELETE", endpoint:"/session") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.logout")
			onComplete(e)
		})
		task.resume()
		
	}
	
	// =================================================================================
	
	static func login(withUsername username: String, andPassword password: String, onComplete: @escaping(ServerError?) -> Void)
    {
        let json = ["username": username, "password": password].asJson()

        guard var request = getRequest(method:"POST", endpoint:"/session") else { return }
        request.httpBody = json
        
        let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.login()")
			{
				onComplete(e)
				return
			}

			guard let dict = data?.asDictionary(),
				let sessionKey = dict["session_key"] as? String,
				let userid = dict["user_id"] as? UserID else
			{
				onComplete(ServerError.processingError("ServerAPI.login(): Could not parse session key from response"))
				return
			}
			
			AppData.currentUser = User()
			AppData.currentUser!.ID = userid
			AppData.currentUser!.session = sessionKey
			onComplete(nil)
		})
		task.resume()
	}
	
	// =================================================================================
	//                               Leaderboard Management
	// =================================================================================
	
	// TODO: put leaderboard stuff here
	
	// =================================================================================
	//                               Achievement Management
	// =================================================================================
	
	static func loadAchievementMetadata(onComplete:@escaping ([AchievementClass]?, ServerError?) -> Void)
	{
		if AppData.DEMO_MODE { onComplete([], nil); return }
		guard let request = getRequest(method:"GET", endpoint:"/achievements") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.loadAchievementMetadata()")
			{
				onComplete(nil, e);
				return
			}
			
			guard let d = data,
				let json = try? JSONSerialization.jsonObject(with:d, options:[]) as? [String:Any],
				let achievementList = json["achievements"] as? [Any] else
			{
				onComplete(nil, ServerError.invalidResponseData("ServerAPI.loadAchievementMetadata(): Data not a JSON"))
				return
			}
			
			// parse the achievement stuff
			var classes = [AchievementClassID:AchievementClass]()
			
			for a in achievementList
			{
				guard let dict			= a as? [String:Any]						else { continue }
				guard let achievementID = dict["achievement_id"] as? AchievementID	else { continue }
				guard let classID		= dict["class_id"] as? AchievementClassID	else { continue }
				guard let goal			= dict["rank"] as? Int						else { continue }
				guard let title			= dict["title"] as? String					else { continue }
				guard let description	= dict["description"] as? String			else { continue }
				
				let achievement = Achievement(id:achievementID, classID:classID, title:title, description:description, goal:goal)
				
				if let achievementClass = classes[classID]
				{
					achievementClass.addAchievement(achievement)
				}
				else
				{
					let achievementClass = AchievementClass(id:classID)
					achievementClass.addAchievement(achievement)
					classes[classID] = achievementClass
				}
			}
			
			let allClasses = classes.map { return $1 }
			onComplete(allClasses, nil)
		})
		task.resume()
	}
	
	// =================================================================================
	
	static func loadAchievements(onComplete:@escaping ([AchievementClassID:Int]?, ServerError?) -> Void)
	{
		guard let request = getRequest(method:"GET", endpoint:"/achievements/progress") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.loadAchievements()")
			{
				onComplete(nil, e);
				return
			}
			
			guard let d = data,
				let json = try? JSONSerialization.jsonObject(with:d, options:[]) as? [String:Any] else
			{
				onComplete(nil, ServerError.invalidResponseData("ServerAPI.loadAchievements(): Data not a JSON"))
				return
			}
			
			// parse the achievement stuff
			var result = [AchievementClassID:Int]()
			
			for (stringID, anyCount) in json
			{
				guard let classID = AchievementClassID(stringID) else { continue }
				guard let count = anyCount as? Int else { continue }
				result[classID] = count
			}
			
			onComplete(result, nil)
		})
		task.resume()
	}
	
	// =================================================================================
	//                                Game Management
	// =================================================================================
	
	static func gameForLocation(_ location:CLLocationCoordinate2D, onComplete:@escaping (Game?, ServerError?) -> Void)
	{
		if AppData.DEMO_MODE
		{
			let game = Game(demoMap:DemoStub.missouriSandTMap())
			DemoStub.seedPaint(into:game)
			onComplete(game, nil)
			return
		}
		guard let request = getRequest(method:"GET", endpoint:"/lobby/\(location.latitude)/\(location.longitude)") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.gameForLocation()")
			{
				onComplete(nil, e)
				return
			}
			
			guard let d = data,
				let json = try? JSONSerialization.jsonObject(with:d, options:[]) as? [String:Any],
				let game = Game(json) else
			{
				onComplete(nil, ServerError.invalidResponseData("ServerAPI.gameForLocation(): Data not a JSON"))
				return
			}
			
			onComplete(game, nil)
		})
		task.resume()
	}
	
	// =================================================================================
	
	static func map(for id:MapID, onComplete:@escaping (Map?, Error?) -> Void)
	{
		if AppData.DEMO_MODE { onComplete(DemoStub.missouriSandTMap(), nil); return }
		guard let request = getRequest(method:"GET", endpoint:"/atlas/\(id)") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.map()")
			{
				onComplete(nil, e)
				return
			}
			
			guard let d = data,
				let json = try? JSONSerialization.jsonObject(with:d, options:[]) as? [String:Any],
				let map = Map(json) else
			{
				onComplete(nil, ServerError.invalidResponseData("ServerAPI.map(): Data not a JSON"))
				return
			}
			
			onComplete(map, nil)
		})
		task.resume()
	}
	
	// =================================================================================
	
	static func join(game:Game, onComplete:@escaping (ServerError?) -> Void)
	{
		if AppData.DEMO_MODE
		{
			let me = Player()
			me.team = .blue
			me.name = "me"
			me.id = AppData.currentUser?.ID ?? 1
			game.addPlayer(player:me, isMe:true)
			game.serverTime = 0
			onComplete(nil)
			return
		}
		guard let request = getRequest(method:"POST", endpoint:"/game/\(game.id)") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.join()")
			{
				onComplete(e)
				return
			}
			
			guard let d = data,
				let json = try? JSONSerialization.jsonObject(with:d, options:[]) as? [String:Any] else
			{
				onComplete(ServerError.invalidResponseData("ServerAPI.join(): Data not a JSON"))
				return
			}
			
			guard let currentTime = json["server_clock"] as? TimeInterval else { return }
			guard let teamNum = json["team"] as? Int else {  return }
			guard let team = TeamColor(rawValue:teamNum) else { return }
			
			let me = Player()
			me.team = team
			me.name = "me"
			me.id = AppData.currentUser!.ID       // can force unwrap because can't play unless logged in
			
			game.addPlayer(player:me, isMe:true)
			game.serverTime = currentTime
			
			onComplete(nil)
		})
		task.resume()
	}
	
	// =================================================================================
	// Returns a timestamp representing the current game time on the server
	static func serverTime(for game: Game)
	{
		if AppData.DEMO_MODE { return }
		guard let request = getRequest(method:"GET", endpoint:"/game/\(game.id)/ping") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.serverTime()")
			{
				print("ERROR: ServerAPI.serverTime(): \(e)")
				return
			}
			
			guard let d = data,
				let timeString = String(data:d, encoding:.ascii),
				let time = TimeInterval(timeString) else
			{
				print("ERROR: ServerAPI.serverTime(): Returned data not a time")
				return
			}
			
			game.serverTime = time
		})
		task.resume()
	}
	
	// =================================================================================
	
	static func getDiff(_ game:Game, entireState:Bool)
	{
		if AppData.DEMO_MODE { return }
		let state = (entireState ? -1 : game.diffState)
		guard let request = getRequest(method:"GET", endpoint:"/game/\(game.id)/state/\(state)") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.getDiff()")
			{
				print("ERROR: ServerAPI.getDiff(): \(e)")
				return
			}
			
			guard let d = data,
				let jsonObject = try? JSONSerialization.jsonObject(with:d, options:[]),
				let json = jsonObject as? [String:Any] else
			{
				print("ERROR: ServerAPI.getDiff(): Returned data not in JSON format")
				return
			}
			
			// process the updates (send them to game)
			guard let serverTime = json["server_clock"] as? TimeInterval else { return }
			guard let teams = json["tiles"] as? [String:[String:Double]] else { return }
			var updates = [TileUpdate]()
			
			for (teamID, tiles) in teams
			{
				guard let teamNum = Int(teamID) else { continue }
				guard let team = TeamColor(rawValue:teamNum) else { continue }
				
				for (index, timestamp) in tiles
				{
					guard let i = Int(index) else { continue }
					
					var update = TileUpdate()
					update.index = i
					update.team = team
					update.timestamp = TimeInterval(timestamp)
					
					updates.append(update)
				}
			}
			
			print("STATUS: received diff of size \(updates.count) at \(serverTime)")
			
			if let newState = json["state_id"] as? Int
			{
				game.diffState = newState
			}
			
			game.serverTime = serverTime
			game.addUpdates(updates:updates)
		})
		task.resume()
	}
	
	// =================================================================================
	
	static func updateGame(_ game:Game, with tiles: [TileUpdate])
	{
		if AppData.DEMO_MODE { return }
		// only send an update if we are supposed to be sending updates and there is something to send
		guard let me = game.me	else { return }
		guard (tiles.count > 0)	else { return }
		
		// create the JSON data object
		var json = "{\"team\":\(me.team.rawValue), \"tiles\":{"
		
		for i in 0..<tiles.count
		{
			json += "\"\(tiles[i].index)\":\(tiles[i].timestamp)"
			
			if (i != tiles.count - 1)
			{
				json += ","
			}
		}
		
		json += "}}"
		
		// do url REST stuff
		guard var request = getRequest(method:"POST", endpoint:"/game/\(game.id)/state") else { return }
		request.httpBody = json.data(using:.ascii)
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.update()")
			{
				print("ERROR: ServerAPI.update(): \(e)")
				return
			}
		})
		task.resume()
	}
	
	// =================================================================================
	
	static func getStatsForGame(_ game:Game, onComplete:@escaping (GameStats?, ServerError?) -> Void)
	{
		if AppData.DEMO_MODE { onComplete(nil, nil); return }
		guard let request = getRequest(method:"GET", endpoint:"/game/\(game.id)/stats") else { return }
		
		let task = URLSession.shared.dataTask(with:request, completionHandler: {(data:Data?, response:URLResponse?, error:Error?) -> Void in
			if let e = basicResponseValidation(response:response, error:error, prefix:"ServerAPI.statsForGame()")
			{
				onComplete(nil, e)
				return
			}
			
			guard let d = data,
				let json = try? JSONSerialization.jsonObject(with:d, options:[]) as? [String:Any],
				let stats = GameStats(json:json) else
			{
				onComplete(nil, ServerError.invalidResponseData("ServerAPI.join(): Data not a JSON"))
				return
			}
			
			onComplete(stats, nil)
		})
		task.resume()
	}
	
	// =================================================================================
	//									Utilities
	// =================================================================================
	// method is "GET", "POST"...
	static func getRequest(method:String, endpoint:String) -> URLRequest?
	{
		guard let url = URL(string:"\(BASE_URL)\(endpoint)") else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = method
		
		if let user = AppData.currentUser
		{
			request.setValue(user.session, forHTTPHeaderField:"Authorization")
		}
		
		return request
	}
	
	// =================================================================================
	
	static func basicResponseValidation(response:URLResponse?, error:Error?, prefix:String) -> ServerError?
	{
		guard (error == nil) else
		{
			return ServerError.connectionError("\(prefix): \(error!.localizedDescription)")
		}
		guard let r = response as? HTTPURLResponse else
		{
			return ServerError.invalidResponseData("\(prefix): nil response")
		}
		guard (r.statusCode / 100 == 2) else
		{
			return ServerError.unexpectedStatusCode("\(prefix): Response code: \(r.statusCode)")
		}
		
		return nil
	}
	
	// =================================================================================
}

extension Dictionary {
	func asJsonString() -> String? {
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
			
			return String(data: jsonData, encoding: .ascii)!
		} catch {
			return nil
		}
	}
	
	func asJson() -> Data? {
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
			
			return jsonData
		} catch {
			return nil
		}
	}
}

extension Data {
	func asDictionary() -> [String: Any] {
		let jsonObject = try! JSONSerialization.jsonObject(with: self, options: [])
		return jsonObject as! [String:Any]
	}
}

extension Int {
	static func randomInt(from: Int, to: Int) -> Int {
		return from + Int(arc4random_uniform(UInt32(to - from)))
	}
}

extension Array {
	func randomItem() -> Element? {
		if isEmpty { return nil }

		let index = Int.randomInt(from: 0, to: self.count)
		return self[index]
	}
}


// =================================================================================
// Offline demo data — Missouri S&T campus map + prefilled paint, used when
// AppData.DEMO_MODE is true. Lets the app run without a live server (handy for
// screenshots or showing the app off).
// =================================================================================
enum DemoStub
{
	// Demo atlas — a rectangle centered on the Missouri S&T academic core,
	// sized so its aspect ratio matches iPhone portrait (≈2.17:1). This way
	// the paintable board fills the whole screen with no dead margin, and
	// GameMapView can drive its visible region directly off board.boundingRegion.
	static let atlasCenter = CLLocationCoordinate2D(latitude: 37.9545, longitude: -91.7730)
	static let atlasLatMeters = 900.0   // N/S extent
	static let atlasLonMeters = 415.0   // E/W extent  (900/415 ≈ 2.17)

	// Trail-walker tuning. Each "walker" wanders along a chain of waypoints so
	// paintLine() lays down a continuous swept trail instead of isolated dots.
	static let walkersPerTeam   = 6            // bodies per team
	static let stepsPerWalker   = 18           // waypoint segments along each walker's path
	static let stepMeters       = 18.0         // distance between waypoints
	static let brushRadius:Float = 6.0         // narrower brush reads as a line, not a blob
	static let directionJitter  = 0.35         // radians — per-step heading perturbation
	static let incursionWalkers = 2            // walkers per team that cross the midline

	// Timer state for animated reveal. Retained statically so the timer isn't
	// deallocated before it fires; Swift's Timer requires the scheduler to
	// hold a live reference.
	private static var animationTimer: Timer?
	private static var animationFrames: [[TileUpdate]] = []
	private static weak var animationGame: Game?

	// Build a Map that covers the demo atlas. Map.init(_ inRegion:) snaps
	// width/height to whole tile counts automatically.
	static func missouriSandTMap() -> Map
	{
		let region = MKCoordinateRegion(center: atlasCenter,
		                                latitudinalMeters: atlasLatMeters,
		                                longitudinalMeters: atlasLonMeters)
		return Map(region)
	}

	// Seed the board with walking trails — red walkers traverse the west half,
	// blue walkers the east, with a few "incursion" walkers starting on the
	// wrong side so the center looks contested.
	//
	// Pass -DemoAnimate on the command line to stagger the reveal on a timer
	// (useful for recording a GIF); otherwise the full trail set is applied in
	// one shot so static screenshots show the finished picture.
	static func seedPaint(into game: Game)
	{
		let mapW = Double(game.board.width)
		let mapH = Double(game.board.height)
		guard mapW > 0, mapH > 0 else { return }

		let region = game.board.boundingRegion
		let latPerRow = region.span.latitudeDelta  / mapH
		let lonPerCol = region.span.longitudeDelta / mapW
		let topLeftLat = region.center.latitude  + region.span.latitudeDelta  / 2
		let topLeftLon = region.center.longitude - region.span.longitudeDelta / 2

		func coord(row: Double, col: Double) -> CLLocationCoordinate2D
		{
			return CLLocationCoordinate2D(
				latitude:  topLeftLat - (row + 0.5) * latPerRow,
				longitude: topLeftLon + (col + 0.5) * lonPerCol)
		}

		// One waypoint step, in tile (row, col) space. Advances by stepMeters
		// along `heading` (radians, 0 = east, pi/2 = north), bouncing the
		// heading off map edges instead of clipping.
		func advance(row:inout Double, col:inout Double, heading:inout Double)
		{
			let drow = -sin(heading) * stepMeters / Map.TILE_SIZE  // -sin so +y is north
			let dcol =  cos(heading) * stepMeters / Map.TILE_SIZE
			var nr = row + drow
			var nc = col + dcol
			if nr < 0 || nr >= mapH
			{
				heading = -heading                // flip vertical
				nr = max(0, min(mapH - 1, row - drow))
			}
			if nc < 0 || nc >= mapW
			{
				heading = Double.pi - heading     // flip horizontal
				nc = max(0, min(mapW - 1, col - dcol))
			}
			row = nr
			col = nc
			heading += Double.random(in: -directionJitter ... directionJitter)
		}

		// Generate one walker's full trail as a list of TileUpdate batches —
		// one batch per path segment, so animated mode can reveal segments in
		// sync with the other walkers.
		let painter = Player()
		painter.brushRadius = brushRadius

		func walkerTrail(startRow:Double, startCol:Double, team:TeamColor) -> [[TileUpdate]]
		{
			painter.team = team
			var row = startRow
			var col = startCol
			// Initial heading biased north/south (pi/2 or -pi/2) with a wobble,
			// so walkers drift roughly along campus streets rather than
			// straight E/W across the atlas.
			var heading = (Bool.random() ? Double.pi / 2 : -Double.pi / 2)
			              + Double.random(in: -0.8 ... 0.8)

			var segments:[[TileUpdate]] = []
			for _ in 0..<stepsPerWalker
			{
				let fromCoord = coord(row: row, col: col)
				advance(row: &row, col: &col, heading: &heading)
				let toCoord = coord(row: row, col: col)
				let segment = game.board.paintLine(from: fromCoord,
				                                   to: toCoord,
				                                   travelTime: stepMeters / Double(brushRadius),
				                                   forPlayer: painter)
				segments.append(segment)
			}
			return segments
		}

		// Collect per-walker segment lists for both teams.
		var trails:[[[TileUpdate]]] = []

		func seedTeam(_ team:TeamColor, startCols:Range<Double>, incursionStartCols:Range<Double>)
		{
			let normal = walkersPerTeam - incursionWalkers
			for _ in 0..<normal
			{
				let r = Double.random(in: 0 ..< mapH)
				let c = Double.random(in: startCols)
				trails.append(walkerTrail(startRow: r, startCol: c, team: team))
			}
			for _ in 0..<incursionWalkers
			{
				let r = Double.random(in: 0 ..< mapH)
				let c = Double.random(in: incursionStartCols)
				trails.append(walkerTrail(startRow: r, startCol: c, team: team))
			}
		}

		seedTeam(.red,
		         startCols: 0 ..< mapW / 2,
		         incursionStartCols: mapW / 2 ..< mapW)
		seedTeam(.blue,
		         startCols: mapW / 2 ..< mapW,
		         incursionStartCols: 0 ..< mapW / 2)

		// Flatten trails into per-frame batches — for step i across all
		// walkers, concatenate their i-th segments so all walkers advance in
		// lockstep frame by frame.
		var frames:[[TileUpdate]] = Array(repeating: [], count: stepsPerWalker)
		for segments in trails
		{
			for (i, segment) in segments.enumerated() where i < frames.count
			{
				frames[i] += segment
			}
		}

		let animate = ProcessInfo.processInfo.arguments.contains("-DemoAnimate")
		if animate
		{
			startAnimatedReveal(game: game, frames: frames)
		}
		else
		{
			// Immediate mode — flatten everything and apply in one batch.
			_ = game.board.update(tiles: frames.flatMap { $0 })
		}
	}

	// Drive a Timer that drops one frame of tile updates onto the board every
	// `interval` seconds and forwards the applied tiles through the Game's
	// delegate so the map renderer (and minimap) pick them up.
	private static func startAnimatedReveal(game:Game, frames:[[TileUpdate]])
	{
		animationTimer?.invalidate()
		animationFrames = frames
		animationGame = game

		// Spread frames across ~10 seconds so the reveal is visible in the
		// ~15 s game GIF without rushing.
		let interval:TimeInterval = max(0.3, 10.0 / Double(max(frames.count, 1)))
		animationTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
			guard let g = animationGame, !animationFrames.isEmpty else
			{
				timer.invalidate()
				animationTimer = nil
				return
			}
			let frame = animationFrames.removeFirst()
			let applied = g.board.update(tiles: frame)
			g.delegate?.boardUpdated(tiles: applied)
		}
	}
}
