import UIKit

enum SplatState
{
	case appearing
	case existing
	case disappearing
	case dead
}

class SplatView : UIImageView, CAAnimationDelegate
{
	static let APPEAR_DURATION:TimeInterval = 0.05		// how long it takes for a splat to "splat"/appear fully
	static let EXIST_DURATION:TimeInterval = 7			// how long each splat lasts after having "splatted"
	static let DISAPPEAR_DURATION:TimeInterval = 5		// how long it takes for a splat to fully fade out
	static let SPLAT_SIZE:Int = 100
	
	var state:SplatState
	
	private var maskWidth:Int
	private var maskHeight:Int
	private var stateStartDate:Date		// date when we entered the current state (appearing vs not appearing (existing))
	
	// =================================================================================
	
	init(color:UIColor, at loc:CGPoint)
	{
		state = .appearing
		stateStartDate = Date()
		maskWidth = Int(CGFloat(SplatView.SPLAT_SIZE) * 1.1)		// *1.1 to not cut off the top right splatter 
		maskHeight = Int(CGFloat(SplatView.SPLAT_SIZE) * 1.1)
		
		super.init(image:SplatView.splatImage(withColor:color))
		
		self.frame.size = CGSize(width:SplatView.SPLAT_SIZE, height:SplatView.SPLAT_SIZE)
		self.center = loc
		initialize()
	}
	
	// =================================================================================
	// This should never happen
	required init?(coder aDecoder: NSCoder)
	{
		state = .appearing
		stateStartDate = Date()
		maskWidth = 0
		maskHeight = 0
		
		super.init(coder:aDecoder) 
		initialize()
	}
	
	// =================================================================================
	
	func initialize()
	{
		guard let image = UIImage(named:"mask.png")?.cgImage else
		{
			return
		}
		
		let maskLayer = CALayer()
		maskLayer.contents = image
		maskLayer.frame = CGRect(x:self.bounds.size.width / 2, y:self.bounds.size.height / 2, width:0, height:0)
		self.layer.mask = maskLayer
		
		// start animating
		let oldBounds = maskLayer.frame
		let newBounds = maskLayer.bounds.insetBy(dx:-(30 + (self.bounds.size.width / 2)), dy:-(30 + (self.bounds.size.height / 2)))
		let appear = CABasicAnimation(keyPath:"bounds")
		appear.fromValue = NSValue(cgRect:oldBounds)
		appear.toValue = NSValue(cgRect:newBounds)
		appear.duration = SplatView.APPEAR_DURATION
		appear.delegate = self
		
		maskLayer.bounds = newBounds
		maskLayer.add(appear, forKey:"appear")
	}
	
	// =================================================================================
	//									CAAnimationDelegate
	// =================================================================================
	
	func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
	{
		// start existing
		state = .existing
		
		// die at the correct time
		Timer.scheduledTimer(withTimeInterval:SplatView.EXIST_DURATION, repeats:false, block:{(_:Timer) -> Void in
			self.state = .disappearing
			
			// begin the disappearing animation (fade out)
			let animator = UIViewPropertyAnimator(duration:SplatView.DISAPPEAR_DURATION, curve:.easeInOut, animations:{() -> Void in
				self.alpha = 0
			})
			animator.addCompletion({(position:UIViewAnimatingPosition) -> Void in
				guard (position == .end) else { return }
				self.state = .dead
			})
			animator.startAnimation()
		})
	}
	
	// =================================================================================
	//										Utilities
	// =================================================================================
	// recolor the splat image to whatever
	static func splatImage(withColor color:UIColor) -> UIImage?
	{
		guard let originalImage = UIImage(named:"redSplat.png") else { return nil }
		guard let cgimage = originalImage.cgImage else { return nil }
		
		let width = Int(originalImage.size.width)
		let height = Int(originalImage.size.height)
		let colorSpace:CGColorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
		guard let context:CGContext = CGContext(data:nil,
												width:width,
												height:height,
												bitsPerComponent:8,
												bytesPerRow:4 * width,
												space:colorSpace,
												bitmapInfo: UInt32(CGBitmapInfo.byteOrder32Little.rawValue) |
															UInt32(CGImageAlphaInfo.premultipliedLast.rawValue))
		else
		{
			return nil
		}
		
		context.draw(cgimage, in:CGRect(x:0, y:0, width:width, height:height))
		
		// get the pixel data and manipulate it
		guard (context.data != nil) else { return nil }
		let data = UnsafeMutableRawBufferPointer(start:context.data, count:width * height * 4)
		var floatr:CGFloat = 0
		var floatg:CGFloat = 0
		var floatb:CGFloat = 0
		var floata:CGFloat = 0
		var factor:CGFloat
		var r:CGFloat
		var g:CGFloat
		var b:CGFloat
		var i:Int = 0
		var j:Int
		var index:Int = 0
		
		color.getRed(&floatr, green:&floatg, blue:&floatb, alpha:&floata)
		r = floatr * 255
		g = floatg * 255
		b = floatb * 255
		
		while (i < height)
		{
			j = 0
			
			while (j < width)
			{
				// if there was color here originally, then put color here
				if (data[index + 0] > 0)
				{
					factor = CGFloat(data[index + 0]) / 255
					data[index + 1] = UInt8(factor * b)	// b
					data[index + 2] = UInt8(factor * g)	// g
					data[index + 3] = UInt8(factor * r)	// r
				}
				
				index += 4
				j += 1
			}
			
			i += 1
		}
		
		// create and return the final image
		if let image = context.makeImage()
		{
			return UIImage(cgImage:image)
		}
		return nil
	}
	
	// =================================================================================
}







