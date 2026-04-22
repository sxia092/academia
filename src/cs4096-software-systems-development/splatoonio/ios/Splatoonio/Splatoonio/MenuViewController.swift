import UIKit
import CoreLocation


class MenuViewController: UIViewController
{
	private var splatView:AnimatedSplatView!
	
	// =================================================================================
	//								Button Actions
	// =================================================================================
	
	@objc func playPressed(_:AnyObject)
	{
		// When we're not using device location (simulator / demo mode) there's no
		// reason to gate on the location permission prompt — just start loading.
		if !AppData.USE_DEVICE_LOCATION
		{
			self.performSegue(withIdentifier:"MenuToLoadingGame", sender:self)
			return
		}

		// verify that we can use location, then start loading
		if let alert = GPSManager.defaultManager().turnOn()
		{
			self.navigationController?.present(alert, animated:true, completion:nil)
		}
		else
		{
			self.performSegue(withIdentifier:"MenuToLoadingGame", sender:self)
		}
	}
	
	// =================================================================================
	
	@objc func customGamePressed(_:AnyObject)
	{
		self.performSegue(withIdentifier:"MenuToCustomGame", sender:self)
	}
	
	// =================================================================================
	
	@objc func scoresPressed(_:AnyObject)
	{
		self.performSegue(withIdentifier:"MenuToScores", sender:self)
	}
	
	// =================================================================================
	
	@objc func optionsPressed(_:AnyObject)
	{
		self.performSegue(withIdentifier:"MenuToOptions", sender:self)
	}
	
	// =================================================================================
	//								UIViewController
	// =================================================================================
	
	private func setupUI()
	{
		let width:CGFloat = self.view.bounds.size.width
		let height:CGFloat = self.view.bounds.size.height
		let PADDING:CGFloat = 12
		let BUTTON_WIDTH:CGFloat = 3 * width / 4
		let BUTTON_HEIGHT:CGFloat = 50
		
		// put all the main contents in a container view to allow easy movement of everything together
		let container = UIView()
		
		// create the title
		let title = UILabel()
		title.font = UIFont.systemFont(ofSize:55)
		title.text = "\(APP_NAME)"
		title.sizeToFit()
		title.frame.origin = CGPoint(x:0, y:0)
		container.addSubview(title)
		
		// create the buttons
		let titles:[String] = ["Play", "Scores", "Options"]
		let actions:[Selector] = [#selector(playPressed(_:)), #selector(scoresPressed(_:)), #selector(optionsPressed(_:))]
		var y:CGFloat = title.frame.maxY + (4 * PADDING)
		
		for i in 0..<titles.count
		{
			let button = MyUtilities.buttonWithSize(size:CGSize(width:BUTTON_WIDTH, height:BUTTON_HEIGHT))
			button.frame.origin = CGPoint(x:title.center.x - (button.frame.size.width / 2), y:y)
			button.setTitle(titles[i], for:.normal)
			button.addTarget(self, action:actions[i], for:.touchUpInside)
			container.addSubview(button)
			
			y += button.frame.size.height + PADDING
		}
		
		MyUtilities.shrinkWrap(view:container)
		container.center = CGPoint(x:width / 2, y:height / 2)
		self.view.addSubview(container)
		
		// create the splat view
		splatView = AnimatedSplatView(frame:self.view.bounds)
		var exclusion = CGRect(x:title.frame.origin.x + container.frame.origin.x,
							   y:title.frame.origin.y + container.frame.origin.y,
							   width:title.frame.size.width,
							   height:title.frame.size.height)
		exclusion = exclusion.insetBy(dx:-30, dy:-30)
		splatView.exclusionZones.append(exclusion)
		self.view.insertSubview(splatView, at:0)
	}
	
	// =================================================================================
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		splatView.start()

		if AppData.DEMO_MODE && ProcessInfo.processInfo.arguments.contains("-DemoAutoPlay")
		{
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
				self?.playPressed(self as AnyObject)
			}
		}
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
		setupUI()
	}
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}

