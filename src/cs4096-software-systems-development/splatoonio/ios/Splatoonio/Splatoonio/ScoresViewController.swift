import UIKit

class ScoresViewController: UIViewController, UITableViewDataSource
{
	private var leaderboards:[UITableView : Leaderboard]!
	private var scrollview:UIScrollView!				// manages the horizontal paging between leaderboards
	private var loadingWheel:UIActivityIndicatorView!

	// =================================================================================
	//								UITableViewDataSource
	// =================================================================================
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return leaderboards[tableView]?.numScores ?? 0
	}
	
	// =================================================================================
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		guard let leaderboard = leaderboards[tableView] else { return UITableViewCell() }
		
		if let cell = tableView.dequeueReusableCell(withIdentifier:"leaderboardCell")
		{
			let placeLabel = cell.accessoryView as! UILabel
			placeLabel.text = "\(indexPath.row + 1)"
			
			cell.textLabel!.text = leaderboard.names[indexPath.row]
			cell.detailTextLabel!.text = leaderboard.scoreAt(indexPath.row)
			
			return cell
		}
		else
		{
			let cell = UITableViewCell(style:.subtitle, reuseIdentifier:"leaderboardCell")
			cell.textLabel!.text = leaderboard.names[indexPath.row]
			cell.detailTextLabel!.text = leaderboard.scoreAt(indexPath.row)
			
			let placeLabel = UILabel()
			placeLabel.font = UIFont.boldSystemFont(ofSize:25)
			placeLabel.text = "\(indexPath.row + 1)"
			placeLabel.textAlignment = .right
			placeLabel.sizeToFit()
			
			if (placeLabel.frame.size.width < 100)
			{
				placeLabel.frame.size.width = 100
			}
			
			cell.accessoryView = placeLabel
			
			return cell
		}
	}
	
	// =================================================================================
	//									UI Actions
	// =================================================================================
	
	@objc func back(_:AnyObject)
	{
		self.navigationController?.popViewController(animated:true)
	}
	
	// =================================================================================
	
	@objc func achievementsPressed(_:AnyObject)
	{
		self.performSegue(withIdentifier:"ScoresToAchievements", sender:self)
	}
	
	// =================================================================================
	//									UI Management
	// =================================================================================
	
	func displayLeaderboards(_ boards:[Leaderboard])
	{
		let PADDING:CGFloat = 10
		
		// stop animating
		loadingWheel.stopAnimating()
		loadingWheel.removeFromSuperview()
		
		// create the tables to display the scores
		leaderboards = [UITableView : Leaderboard]()
		
		for i in 0..<boards.count
		{
			let x = CGFloat(i) * scrollview.frame.size.width
			
			// create the label for the name of the leaderboard
			let title = UILabel()
			title.font = UIFont.systemFont(ofSize:40)
			title.text = boards[i].title
			title.sizeToFit()
			title.frame.origin.y = 2 * PADDING
			title.center.x = x + (scrollview.frame.size.width / 2)
			scrollview.addSubview(title)
			
			// create the table to display the scores
			let table = UITableView()
			table.dataSource = self
			table.separatorStyle = .none
			table.frame = CGRect(x:x,
			                     y:title.frame.maxY + PADDING,
			                     width:scrollview.frame.size.width,
			                     height:scrollview.frame.size.height - (title.frame.maxY + PADDING))
			
			leaderboards[table] = boards[i]
			scrollview.addSubview(table)
		}
		
		scrollview.contentSize = CGSize(width:scrollview.frame.size.width * CGFloat(leaderboards.count),
		                                height:scrollview.frame.size.height)
	}
	
	// =================================================================================
	
	private func setupUI()
	{
		let width = self.view.frame.size.width
		let height = self.view.frame.size.height
		let PADDING:CGFloat = 10
		let BUTTON_HEIGHT:CGFloat = 50
		let BACK_BUTTON_SIZE:CGFloat = 60
		
		// create the bottom button to switch between achievements and leaderboards
		let button = MyUtilities.buttonWithSize(size:CGSize(width:width - (2 * PADDING), height:BUTTON_HEIGHT))
		button.frame.origin = CGPoint(x:PADDING, y:height - (PADDING + BUTTON_HEIGHT))
		button.setTitle("Achievements", for:.normal)
		button.addTarget(self, action:#selector(achievementsPressed(_:)), for:.touchUpInside)
		self.view.addSubview(button)
		
		// create the scrollview
		scrollview = UIScrollView()
		scrollview.frame = CGRect(x:0, y:0, width:width, height:button.frame.origin.y - PADDING)
		scrollview.isPagingEnabled = true
		scrollview.showsVerticalScrollIndicator = false
		scrollview.showsHorizontalScrollIndicator = false
		self.view.addSubview(scrollview)
		
		// create the back button
		let backArrow = UIImageView(image:UIImage(named:"backArrow.png"))
		backArrow.frame.size = CGSize(width:35, height:35)
		backArrow.center = CGPoint(x:BACK_BUTTON_SIZE / 2, y:BACK_BUTTON_SIZE / 2)
		self.view.addSubview(backArrow)
		
		let backButton = UIButton(type:.custom)
		backButton.frame = CGRect(x:0, y:0, width:BACK_BUTTON_SIZE, height:BACK_BUTTON_SIZE)
		backButton.addTarget(self, action:#selector(back(_:)), for:.touchUpInside)
		self.view.addSubview(backButton)
		
		// create the loading wheel
		loadingWheel = UIActivityIndicatorView()
		loadingWheel.center = CGPoint(x:width / 2, y:height / 2)
		loadingWheel.color = .black
		loadingWheel.startAnimating()
		self.view.addSubview(loadingWheel)
	}
	
	// =================================================================================
	//									UIViewController 
	// =================================================================================
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
		
		setupUI()
		
		Timer.scheduledTimer(withTimeInterval:1, repeats:false, block:{(_:Timer) -> Void in
			let boards:[Leaderboard] = [Leaderboard(title:"Fastest Time"),
			                            Leaderboard(title:"Highest Score")]
			
			for i in 0..<10
			{
				boards[0].add(score:Int64(100 - (i * 10)), forPlayer:"Bob")
				boards[1].add(score:Int64(50 - i), forPlayer:"Joe")
			}
			
			AppData.leaderboards = boards
			self.displayLeaderboards(boards)
		})
    }
	
	// =================================================================================
	
	override var prefersStatusBarHidden: Bool
	{
		return true
	}
	
	// =================================================================================
}
