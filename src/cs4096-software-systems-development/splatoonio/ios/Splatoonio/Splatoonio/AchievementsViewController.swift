import UIKit

class AchievementsViewController: UIViewController
{
	private var loadingSpinner:UIActivityIndicatorView!
	private var scrollview:UIScrollView!
	
	// =================================================================================
	//									UI Actions
	// =================================================================================
	
	@objc func scoresPressed(_:AnyObject)
	{
		self.navigationController?.popViewController(animated:true)
	}
	
	// =================================================================================
	//									Loading
	// =================================================================================
	
	func gotAchievements(updates:[AchievementClassID:Int]?, error:ServerError?)
	{
		if let e = error
		{
			print("ERROR: \(e)")
			return
		}
		guard let newValues = updates else { return }
		
		AppData.updateAchievements(updates:newValues)
		
		DispatchQueue.main.async {
			self.displayAchievements(achievements:AppData.allAchievements())
		}
	}
	
	// =================================================================================
	//									UI Management
	// =================================================================================
	
	func displayAchievements(achievements:[Achievement])
	{
		let PADDING:CGFloat = 10
		let PROGRESS_SIZE:CGFloat = 50
		let TEXT_X:CGFloat = PADDING + PROGRESS_SIZE + PADDING
		let TEXT_PADDING:CGFloat = 5
		let TITLE_SIZE:CGFloat = 20
		let DESCRIPTION_SIZE:CGFloat = 15
		
		// remove all previous achievements (required for an achievement update) 
		for v in scrollview.subviews
		{
			v.removeFromSuperview()
		}
		
		// stop loading
		loadingSpinner.removeFromSuperview()
		
		// if there aren't any achievements let the user know
		if (achievements.count == 0)
		{
			let label = UILabel()
			label.text = "No Achievements"
			label.sizeToFit()
			label.center = CGPoint(x:scrollview.bounds.size.width / 2, y:scrollview.bounds.size.height / 2)
			scrollview.addSubview(label)
			scrollview.contentSize = scrollview.bounds.size
			return
		}
		
		// add the achievement views to the scrollview
		var y:CGFloat = 0
		
		for achievement in achievements
		{
			let textView = UIView()
			textView.frame.origin.x = TEXT_X
			textView.frame.size.width = scrollview.frame.maxX - TEXT_X
			
			// create the title label
			let title = UILabel()
			title.font = UIFont.boldSystemFont(ofSize:TITLE_SIZE)
			title.text = achievement.title
			title.numberOfLines = 0
			title.frame.size.width = textView.frame.size.width
			title.sizeToFit()
			title.frame.origin = CGPoint(x:0, y:0)
			textView.addSubview(title)
			
			// create the description
			let description = UILabel()
			description.font = UIFont.systemFont(ofSize:DESCRIPTION_SIZE)
			description.text = achievement.descriptionText
			description.numberOfLines = 0
			description.frame.origin = CGPoint(x:0, y:title.frame.maxY + TEXT_PADDING)
			description.frame.size.width = textView.frame.size.width
			description.sizeToFit()
			textView.addSubview(description)
			
			textView.frame.size.height = description.frame.maxY
			scrollview.addSubview(textView)
			
			// add the progress indicator
			let progressView = ProgressCircleView()
			progressView.frame.size = CGSize(width:PROGRESS_SIZE, height:PROGRESS_SIZE)
			progressView.frame.origin.x = PADDING
			progressView.percentComplete = CGFloat(achievement.currentCount) / CGFloat(achievement.goalCount)
			scrollview.addSubview(progressView)
			
			// align everything
			if (textView.frame.size.height > progressView.frame.size.height)
			{
				progressView.center.y = y + (textView.frame.size.height / 2)
				textView.frame.origin.y = y
				
				y += textView.frame.size.height + PADDING
			}
			else
			{
				progressView.frame.origin.y = y
				textView.center.y = y + (progressView.frame.size.height / 2)
				
				y += progressView.frame.size.height + PADDING
			}
		}
		
		// take off the extra padding
		y -= PADDING
		
		// do the final configuration of the scrollview how that we know what the content is
		scrollview.contentSize = CGSize(width:scrollview.frame.size.width, height:y)
	}
	
	// =================================================================================
	
	private func setupLoadingUI()
	{
		let width = self.view.frame.size.width
		let height = self.view.frame.size.height
		let PADDING:CGFloat = 10
		let BUTTON_HEIGHT:CGFloat = 50
		
		// create the title
		let title = UILabel()
		title.font = UIFont.systemFont(ofSize:40)
		title.text = "Achievements"
		title.sizeToFit()
		title.center.x = width / 2
		title.frame.origin.y = 2 * PADDING
		self.view.addSubview(title)
		
		// create the bottom button to switch between achievements and leaderboards
		let button = MyUtilities.buttonWithSize(size:CGSize(width:width - (2 * PADDING), height:BUTTON_HEIGHT))
		button.frame.origin = CGPoint(x:PADDING, y:height - (PADDING + BUTTON_HEIGHT))
		button.setTitle("Scores", for:.normal)
		button.addTarget(self, action:#selector(scoresPressed(_:)), for:.touchUpInside)
		self.view.addSubview(button)
		
		// setup the scrollview here, then populate it once the data loads
		let scrollviewy = title.frame.maxY + (2 * PADDING)
		let scrollviewHeight = (button.frame.origin.y - PADDING) - scrollviewy
		scrollview = UIScrollView()
		scrollview.frame = CGRect(x:0, y:scrollviewy, width:width, height:scrollviewHeight)
		scrollview.showsVerticalScrollIndicator = true
		scrollview.showsHorizontalScrollIndicator = true
		scrollview.isScrollEnabled = true
		self.view.addSubview(scrollview)
		
		// add the loading spinner
		loadingSpinner = UIActivityIndicatorView()
		loadingSpinner.center = CGPoint(x:width / 2, y:height / 2)
		loadingSpinner.color = .black
		loadingSpinner.startAnimating()
		self.view.addSubview(loadingSpinner)
	}
	
	// =================================================================================
	//									UIViewController 
	// =================================================================================
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		// TODO: instead of setting up all the UI now, setup a loading wheel and the scores button and kick off a
		// query to the server for the user's achievements. Setup all the UI and remove the loading wheel when
		// the query return
		setupLoadingUI()
		ServerAPI.loadAchievements(onComplete:gotAchievements)
	}
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}
