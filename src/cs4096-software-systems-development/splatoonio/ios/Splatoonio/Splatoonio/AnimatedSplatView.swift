import UIKit

class AnimatedSplatView: UIView
{
	static let UPDATE_RATE:TimeInterval = 10		// check for creating and removing splats this many times per second
	static let SPLAT_INTERVAL:TimeInterval = 0.2	// create a new splat every 0.2 seconds
	
	var exclusionZones:[CGRect]
	
	private var splats:[SplatView]
	private var animationTimer:Timer!
	private var lastSplat:Date!
	
	// =================================================================================
	//									Initializiers
	// =================================================================================
	
	override init(frame: CGRect)
	{
		exclusionZones = [CGRect]()
		splats = [SplatView]()
		lastSplat = nil
		
		super.init(frame:frame)
		start()
	}
	
	// =================================================================================
	
	required init?(coder aDecoder: NSCoder)
	{
		exclusionZones = [CGRect]()
		splats = [SplatView]()
		lastSplat = nil
		
		super.init(coder:aDecoder)
		start()
	}
	
	// =================================================================================
	//									Normal Functions
	// =================================================================================
	
	func start()
	{
		let interval = 1 / AnimatedSplatView.UPDATE_RATE
		
		animationTimer?.invalidate()
		animationTimer = Timer.scheduledTimer(timeInterval:interval, target:self, selector:#selector(update(t:)), userInfo:nil, repeats:true)
	}
	
	// =================================================================================
	
	@objc func update(t:Timer)
	{
		let now = Date()
		
		// create a new splat
		if (lastSplat == nil) || (now.timeIntervalSince(lastSplat!) >= AnimatedSplatView.SPLAT_INTERVAL)
		{
			createSplat()
			lastSplat = now
		}
		
		// remove dead splats
		var i:Int = 0
		
		while (i < splats.count)
		{
			if (splats[i].state == .dead)
			{
				splats[i].removeFromSuperview()
				splats.remove(at:i)
				i -= 1
			}
			
			i += 1
		}
	}
	
	// =================================================================================
	
	func stop()
	{
		animationTimer?.invalidate()
		animationTimer = nil
	}
	
	// =================================================================================
	
	func reset()
	{
		stop()
		
		for splat in splats
		{
			splat.removeFromSuperview()
		}
		
		splats.removeAll(keepingCapacity:true)
	}
	
	// =================================================================================
	//									Utilities
	// =================================================================================
	
	func createSplat()
	{
		let colors:[UIColor] = [.red, .red, .blue, .green, .orange, .cyan, .purple, .yellow]
		var valid:Bool
		var point:CGPoint
		
		repeat
		{
			point = CGPoint(x:CGFloat(Int(arc4random()) % Int(self.frame.size.width)),
							y:CGFloat(Int(arc4random()) % Int(self.frame.size.height)))
			
			// don't create a splat centered in an exclusion zone
			valid = true
			
			for rect in exclusionZones
			{
				if (rect.contains(point))
				{
					valid = false
					break
				}
			}
		} while (!valid)
		
		let splat = SplatView(color:colors[Int(arc4random()) % colors.count], at:point)
		
		splats.append(splat)
		self.addSubview(splat)
	}
	
	// =================================================================================

}






