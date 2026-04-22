import UIKit

class PieChartView: UIView
{
	private static let GROW_DURATION:TimeInterval = 0.75	// how many seconds the chart growing animation lasts
	private static let GROW_DELAY:TimeInterval = 0.5		// how long until the grow animation starts
	private static let GROW_FPS:TimeInterval = 60			// FPS of the grow animation
	private static let DEFAULT_FONT_SIZE:CGFloat = 20
	
	private var values:[CGFloat]
	private var colors:[UIColor]
	private var labels:[UILabel]
	private var radius:CGFloat
	private var chartCenter:CGPoint
	private var maxPercentFill:CGFloat		// How much of the pie chart we should treat as 100% (how big of a slice do we
											// use to represent the full chart). Used to animate the chart filling up.
	private var doneGrowing:Bool
	private var growTimer:Timer?
	
	var showPercentages:Bool
	var lineColor:UIColor
	var fontSize:CGFloat					// font size for the percentage labels
	var chartInset:CGPoint					// required to allow room for percentage labels that are off the chart because of small slices
	{
		didSet
		{
			chartCenter = CGPoint(x:radius + chartInset.x, y:radius + chartInset.y)
		}
	}
	
	var totalValue:CGFloat
	{
		var sum:CGFloat = 0
		
		for value in values
		{
			sum += value
		}
		
		return sum
	}
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init()
	{
		values = [CGFloat]()
		colors = [UIColor]()
		labels = [UILabel]()
		showPercentages = true
		lineColor = .black
		radius = 0
		chartCenter = .zero
		maxPercentFill = 0
		doneGrowing = false
		growTimer = nil
		fontSize = PieChartView.DEFAULT_FONT_SIZE
		chartInset = CGPoint(x:2 * fontSize, y:fontSize)
		
		super.init(frame:.zero)
		
		initialize()
	}
	
	// =================================================================================
	
	required init?(coder aDecoder: NSCoder)
	{
		values = [CGFloat]()
		colors = [UIColor]()
		labels = [UILabel]()
		showPercentages = true
		lineColor = .black
		radius = 0
		chartCenter = .zero
		maxPercentFill = 0
		doneGrowing = false
		growTimer = nil
		fontSize = PieChartView.DEFAULT_FONT_SIZE
		chartInset = CGPoint(x:2 * fontSize, y:fontSize)
		
		super.init(coder:aDecoder)
		
		initialize()
	}
	
	// =================================================================================
	
	private func initialize()
	{
		self.backgroundColor = .clear
		self.clipsToBounds = false
		
		growTimer?.invalidate()
		
		growTimer = Timer.scheduledTimer(withTimeInterval:PieChartView.GROW_DELAY,
										 repeats:false,
										 block:{(_:Timer) -> Void in
			self.growTimer = Timer.scheduledTimer(withTimeInterval:1 / PieChartView.GROW_FPS,
												  repeats:true,
												  block:{(timer:Timer) -> Void in
				let numFrames = PieChartView.GROW_FPS * PieChartView.GROW_DURATION
				self.maxPercentFill += CGFloat(1.0 / numFrames)
				self.setNeedsDisplay()
				
				if (self.maxPercentFill >= 1)
				{
					self.maxPercentFill = 1
					self.doneGrowing = true
					timer.invalidate()
				}
			})
		})
	}
	
	// =================================================================================
	//									  Drawing
	// =================================================================================
	
    override func draw(_ rect: CGRect)
	{
		guard let context = UIGraphicsGetCurrentContext() else { return }
		let diameter = radius * 2
		
		// draw the outer circle
		context.setLineCap(.round)
		context.setLineJoin(.round)
		context.setLineWidth(2)
		context.setStrokeColor(UIColor.black.cgColor)
		context.strokeEllipse(in:CGRect(x:chartInset.x, y:chartInset.y, width:diameter, height:diameter))
		
		// fill in the pie slices
		var prevValues:CGFloat = 0
		let total = self.totalValue
		
		context.setStrokeColor(lineColor.cgColor)
		
		for i in 0..<values.count
		{
			let currentPercent = (prevValues + values[i]) / total
			let prevPercent = prevValues / total
			
			context.setFillColor(colors[i].cgColor)
			drawSlice(from:prevPercent, to:currentPercent, radius:radius, context:context)
			
			prevValues += values[i]
		}
		
		// draw the labels if necessary
		if (doneGrowing && showPercentages)
		{
			drawPercentages(context:context)
		}
    }
	
	// =================================================================================
	
	private func drawPercentages(context:CGContext)
	{
		let precisionDigits:Int = 1
		let precision:Int = 10
		let total = self.totalValue
		var prevValues:CGFloat = 0
		
		for i in 0..<values.count
		{
			let fraction = values[i] / total
			var percentage = Int(round(fraction * 100 * CGFloat(precision)))
			var string:String
			let decimal = percentage % precision
			percentage /= precision
			
			if (decimal != 0)
			{
				string = String(format:"%d.%0\(precisionDigits)d%%", percentage, decimal)
			}
			else
			{
				string = String(format:"%d%%", percentage)
			}
			
			// compute the center coordinate of the string
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = .center
			let attrs:[NSAttributedString.Key:Any] = [NSAttributedString.Key.font : UIFont.systemFont(ofSize:fontSize),
			                                         NSAttributedString.Key.paragraphStyle : paragraphStyle]
			let textSize = string.size(withAttributes:attrs)
			
			let start = angleForPercentage(percent:prevValues / total)
			let end = angleForPercentage(percent:(prevValues + values[i]) / total)
			let half = (start + end) / 2
			let angle = end - start
			let maxAdjustmentAngle:CGFloat = 0.25 * 2 * .pi
			
			var textRadius = 0.5 * radius
			
			// attempt to move the percentage label to a better spot in the slice (farther out for thinner slices) to be more readable
			if (angle < maxAdjustmentAngle)
			{
				// apply a curve so the text doesn't move out linearly
				let angleFraction = angle / maxAdjustmentAngle
				let converted = (angleFraction > 0.4 ? pow(angleFraction, 0.2) : angleFraction * angleFraction * angleFraction)
				
				textRadius += (0.5 * radius) * (1 - converted)			// the main movement
				textRadius += (textSize.width / 2) * abs(cos(half))		// account for text width
				textRadius += (textSize.height / 2) * abs(sin(half))	// account for text height
			}
			
			let textCenter = CGPoint(x:chartCenter.x + (textRadius * cos(half)),
			                         y:chartCenter.y + (textRadius * sin(half)))
			
			string.draw(at:CGPoint(x:textCenter.x - (textSize.width / 2), y:textCenter.y - (textSize.height / 4)), withAttributes:attrs)
			
			prevValues += values[i]
		}
	}
	
	// =================================================================================
	// from and to are percentages of a full circle starting from north and going clockwise
	private func drawSlice(from:CGFloat, to:CGFloat, radius:CGFloat, context:CGContext)
	{
		context.beginPath()
		context.move(to:chartCenter)
		context.addArc(center: chartCenter,
		               radius: radius,
		               startAngle: angleForPercentage(percent:from),
		               endAngle: angleForPercentage(percent:to),
		               clockwise: false)
		context.closePath()
		
		// fill and stroke the pie slice
		context.drawPath(using:.fillStroke)
	}
	
	// =================================================================================
	
	private func angleForPercentage(percent:CGFloat) -> CGFloat
	{
		let originAngle:CGFloat = -(.pi * 0.5)
		
		if (maxPercentFill == 0)
		{
			return originAngle
		}
		
		let pi2:CGFloat = 2 * .pi * maxPercentFill
		let angle = (percent * pi2) + originAngle
		
		return angle
	}
	
	// =================================================================================
	//								Normal Functions
	// =================================================================================
	
	func addSlice(value:CGFloat, color:UIColor)
	{
		values.append(value)
		colors.append(color)
		self.setNeedsDisplay()
	}
	
	// =================================================================================
	
	func insertSlice(value:CGFloat, color:UIColor, atIndex index:Int)
	{
		values.insert(value, at:index)
		colors.insert(color, at:index)
		self.setNeedsDisplay()
	}
	
	// =================================================================================
	
	func reset()
	{
		for label in labels
		{
			label.removeFromSuperview()
		}
		
		values.removeAll()
		colors.removeAll()
		labels.removeAll()
		
		maxPercentFill = 0
		doneGrowing = false

		self.setNeedsDisplay()
	}
	
	// =================================================================================
	//									Overrides
	// =================================================================================
	
	override var frame: CGRect
	{
		didSet
		{
			let xradius = (self.bounds.size.width / 2) - chartInset.x
			let yradius = (self.bounds.size.height / 2) - chartInset.y
			radius = max(0, min(xradius, yradius))
			chartCenter = CGPoint(x:radius + chartInset.x, y:radius + chartInset.y)
			
			// tweak the size it if it makes a difference (adjust the size to account for the new radius with the chart insets applied)
			if (abs(xradius - yradius) > 0.1)
			{
				self.frame.size = CGSize(width:2 * (radius + chartInset.x), height:2 * (radius + chartInset.y))
			}
		}
	}
	
	// =================================================================================
}









