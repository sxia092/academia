import UIKit

class GameResultsViewController: UIViewController
{
	var game:Game!
	
	private var titleLabel:UILabel!
	private var pieChart:PieChartView!
	private var distanceLabel:UILabel!
	private var paintedLabel:UILabel!
	private var stolenLabel:UILabel!
	private var remainingLabel:UILabel!
	private var loadingWheel:UIActivityIndicatorView!
	
	// =================================================================================
	//									UI Actions
	// =================================================================================
	
	@objc func menuPressed(_:AnyObject)
	{
		gotoMenu()
	}
	
	// =================================================================================
	
	func gotoMenu()
	{
		// figure out which VC the menu is and pop back to that one
		if let vcs = self.navigationController?.viewControllers
		{
			for vc in vcs
			{
				if vc is MenuViewController
				{
					self.navigationController?.popToViewController(vc, animated:true)
				}
			}
		}
	}
	
	// =================================================================================
	//									UI Management
	// =================================================================================
	
	func update(withStats stats:GameStats?, error:ServerError?)
	{
		if let e = error
		{
			// let the user know we couldn't get results with an option to retry
			print("ERROR: \(e)")
			let alert = UIAlertController(title:"Uh-oh",
										  message:"Could not retrieve postgame statistics",
										  preferredStyle:.alert)
			let menuAction = UIAlertAction(title:"Menu",
										   style:.cancel,
										   handler:{(_:UIAlertAction) -> Void in self.gotoMenu() })
			let tryAgain = UIAlertAction(title:"Try Again",
										 style:.default,
										 handler:{(_:UIAlertAction) -> Void in
											ServerAPI.getStatsForGame(self.game, onComplete:self.update) })
			alert.addAction(menuAction)
			alert.addAction(tryAgain)
			
			self.navigationController?.present(alert, animated:true, completion:nil)
			return
		}
		
		// check for valid stats before creating the UI so that if the stats are bad and the UI hasn't been created yet,
		// we don't create an empty UI and never fill it
		guard let data = stats else { return }
		
		DispatchQueue.main.async {
			if (self.pieChart == nil)
			{
				self.setupUI()
			}
			
			self.setValues(stats:data)
		}
	}
	
	// =================================================================================
	
	private func setValues(stats:GameStats)
	{
		guard let me = game.me else { return }
		guard let myStats = stats.userStats[me.id] else { return }
		
		var unpainted = stats.totalArea
		
		distanceLabel.text = "\(Int(round(me.distance))) m"
		paintedLabel.attributedText = MyUtilities.metersSquared("\(myStats.areaPainted) ")
		stolenLabel.attributedText = MyUtilities.metersSquared("\(myStats.areaStolen) ")
		remainingLabel.attributedText = MyUtilities.metersSquared("\(myStats.areaRemaining) ")
		
		pieChart.reset()
		
		for (team, area) in stats.remaining
		{
			unpainted -= area
			pieChart.addSlice(value:CGFloat(area), color:team.color().uicolor())
		}
		
		if (unpainted > 0)
		{
			pieChart.addSlice(value:CGFloat(unpainted), color:.white)
		}
	}
	
	// =================================================================================
	
	private func setupUI()
	{
		let width = self.view.frame.size.width
		let PADDING:CGFloat = 10
		
		loadingWheel.stopAnimating()
		
		// create the map coverage pie chart
		let chartInset:CGFloat = PADDING
		pieChart = PieChartView()
		pieChart.frame = CGRect(x:chartInset,
								y:titleLabel.frame.maxY + chartInset,
								width:width - (2 * chartInset),
								height:width - (2 * chartInset))
		self.view.addSubview(pieChart)
		
		// create all the statistic labels
		distanceLabel = UILabel()
		paintedLabel = UILabel()
		stolenLabel = UILabel()
		remainingLabel = UILabel()
		
		let labels:[UILabel] = [distanceLabel, paintedLabel, stolenLabel, remainingLabel]
		let titles:[String] = ["Distance Travelled:", "Area Painted:", "Area Stolen:", "Surviving Paint:"]
		var y:CGFloat = pieChart.frame.maxY
		
		for i in 0..<labels.count
		{
			let title = UILabel()
			title.font = UIFont.systemFont(ofSize: 20)
			title.text = titles[i]
			title.sizeToFit()
			title.frame.origin = CGPoint(x:PADDING, y:y)
			self.view.addSubview(title)
			
			labels[i].font = UIFont.systemFont(ofSize: 20)
			labels[i].text = "123"		// dummy text just to get the proper label height
			labels[i].sizeToFit()
			labels[i].textAlignment = .right
			labels[i].frame = CGRect(x:title.frame.maxX, y:y, width:(width - PADDING) - title.frame.maxX, height:labels[i].frame.size.height)
			self.view.addSubview(labels[i])
			
			y += max(labels[i].frame.size.height, title.frame.size.height) + PADDING
		}
	}
	
	// =================================================================================
	
	private func setupInitialUI()
	{
		let width = self.view.frame.size.width
		let height = self.view.frame.size.height
		let PADDING:CGFloat = 10
		let BUTTON_HEIGHT:CGFloat = 50
		let BUTTON_SIZE:CGSize = CGSize(width:width - (2 * PADDING), height:BUTTON_HEIGHT)
		
		// create the title
		titleLabel = UILabel()
		titleLabel.font = UIFont.systemFont(ofSize:40)
		titleLabel.text = "Results"
		titleLabel.sizeToFit()
		titleLabel.center.x = width / 2
		titleLabel.frame.origin.y = 2 * PADDING
		self.view.addSubview(titleLabel)
		
		// create the loading spinner
		loadingWheel = UIActivityIndicatorView()
		loadingWheel.center = CGPoint(x:width / 2, y:height / 2)
		loadingWheel.hidesWhenStopped = true
		loadingWheel.color = .black
		loadingWheel.startAnimating()
		self.view.addSubview(loadingWheel)
		
		// create the menu button
		let menuButton = MyUtilities.buttonWithSize(size:BUTTON_SIZE)
		menuButton.center.x = width / 2
		menuButton.frame.origin.y = height - (PADDING + BUTTON_HEIGHT)
		menuButton.setTitle("Menu", for:.normal)
		menuButton.addTarget(self, action:#selector(menuPressed(_:)), for:.touchUpInside)
		self.view.addSubview(menuButton)
	}
	
	// =================================================================================
	//								UIViewController
	// =================================================================================
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupInitialUI()
	}
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}
