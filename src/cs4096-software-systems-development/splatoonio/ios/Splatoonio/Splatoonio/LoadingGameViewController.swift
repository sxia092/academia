import UIKit
import CoreLocation


class LoadingGameViewController: UIViewController
{
	private static let UPDATE_INTERVAL:TimeInterval = 0.01
	
	private var state:LoadingState = .gettingLocation
	private var game:Game!
	private var updateTimer:Timer!		// checks the loading state every UPDATE_INTERVAL seconds
	private var splatView:AnimatedSplatView!
	
	@IBOutlet private var statusLabel:UILabel!
	
	// =================================================================================
	
	private enum LoadingState
	{
		case gettingLocation
		case loadingGame
		case joiningGame
	}
	
	// =================================================================================
	//								Loading States
	// =================================================================================
	
	private func getLocation()
	{
		state = .gettingLocation
		
		if (!AppData.USE_DEVICE_LOCATION)
		{
			loadGame()
		}
		else
		{
			if let alert = GPSManager.defaultManager().turnOn()
			{
				self.navigationController?.popViewController(animated:true)
				self.present(alert, animated:false, completion:nil)
				return
			}
			
			Timer.scheduledTimer(withTimeInterval:5.0, repeats:false, block: {(Timer) -> Void in
				self.loadGame()
			})
		}
	}
	
	// =================================================================================
	
	private func loadGame()
	{
		state = .loadingGame
		
		if (!AppData.USE_DEVICE_LOCATION)
		{
			let loc = CLLocationCoordinate2DMake(37.953994, -91.773638)
			ServerAPI.gameForLocation(loc, onComplete: self.loadedGame)
		}
		else if let loc = GPSManager.defaultManager().currentLocation
		{
			ServerAPI.gameForLocation(loc.coordinate, onComplete: self.loadedGame)
		}
	}
	
	// =================================================================================
	
	private func loadedGame(_ loadedGame:Game?, error:Error?)
	{
		if let e = error
		{
			displayError("\(e)")
			return
		}
		guard let g = loadedGame else
		{
			displayError("ERROR: Could not load game")
			return
		}
		
		print("STATUS: loaded game")
		game = g
		state = .joiningGame
		
		ServerAPI.join(game:game, onComplete:self.loadingComplete)
	}
	
	// =================================================================================
	
	private func loadingComplete(error:Error?)
	{
		if let e = error
		{
			displayError("\(e)")
			return
		}
		
		// TODO: query the server every second or so until the game is ready, then transition
		// to the game after a countdown or something
		
		// We are on a background thread, and UI updates can only be done on the main thread,
		// so queue up the UI updates to execute on the main thread
		DispatchQueue.main.async {
			print("STATUS: joined game")
			self.performSegue(withIdentifier:"LoadingGameToGame", sender:self)
		}
	}
	
	// =================================================================================
	
	func displayError(_ error:String)
	{
		DispatchQueue.main.async {
			// TODO: throw up alert telling the user loading failed
			print("ERROR: \(error)")
			self.navigationController?.popViewController(animated:true)
		}
	}
	
	// =================================================================================
	//								UIViewController
	// =================================================================================
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		let vc = segue.destination as? GameViewController
		vc?.game = game
		
		game.startGame()
		updateTimer.invalidate()
	}
	
	// =================================================================================
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		splatView.start()
	}
	
	// =================================================================================
	
	override func viewDidDisappear(_ animated: Bool)
	{
		super.viewDidDisappear(animated)
		splatView.reset()
	}
	
	// =================================================================================
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		getLocation()
		
		updateTimer = Timer.scheduledTimer(withTimeInterval:LoadingGameViewController.UPDATE_INTERVAL,
		                                   repeats:true,
		                                   block:{(Timer) -> Void in
			switch (self.state)
			{
				case .gettingLocation:	self.statusLabel.text = "Getting Location"
				case .loadingGame:		self.statusLabel.text = "Loading Game"
				case .joiningGame:		self.statusLabel.text = "Joining Game"
			}
		})
		
		// create the splat view
		splatView = AnimatedSplatView(frame:self.view.bounds)
		let exclusion = statusLabel.frame.insetBy(dx:-30, dy:-30)
		splatView.exclusionZones.append(exclusion)
		self.view.insertSubview(splatView, at:0)
    }
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}
