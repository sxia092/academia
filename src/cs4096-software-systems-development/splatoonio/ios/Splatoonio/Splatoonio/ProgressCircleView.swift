import UIKit

class ProgressCircleView: UIView
{
	private var percent:CGFloat = 0		// 0 to 1
	
	var percentComplete:CGFloat
	{
		get
		{
			return percent
		}
		set
		{
			percent = newValue
			
			// clamp to the percentage bounds
			if (0 > percent) { percent = 0 }
			if (1 < percent) { percent = 1 }
			
			self.setNeedsDisplay()
		}
	}
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init()
	{
		super.init(frame:.zero)
		self.backgroundColor = .clear
	}
	
	// =================================================================================
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder:aDecoder)
		self.backgroundColor = .clear
	}
	
	// =================================================================================
	//									  Drawing
	// =================================================================================
	
    override func draw(_ rect: CGRect)
	{
		guard let context = UIGraphicsGetCurrentContext() else { return }
		let radius = min(self.bounds.size.width / 2, self.bounds.size.height / 2) - 1
		let diameter = radius * 2
		
		// draw the outer circle
		context.setStrokeColor(UIColor.black.cgColor)
		context.strokeEllipse(in:CGRect(x:1, y:1, width:diameter, height:diameter))
		
		// draw the inner fill
		let center = CGPoint(x:radius + 1, y:radius + 1)
		
		let pi2:CGFloat = 2 * .pi
		var end = (percent * pi2) - (.pi * 0.5)
		end -= CGFloat(Int(end / pi2)) * pi2
		
		context.beginPath()
		context.move(to:center)
		context.addLine(to:CGPoint(x:center.x, y:center.y - radius))
		context.addArc(center: center,
		               radius: radius,
		               startAngle: .pi * -0.5,
		               endAngle: end,
		               clockwise: false)
		context.addLine(to:center)
		context.fillPath()
    }
	
	// =================================================================================
}
