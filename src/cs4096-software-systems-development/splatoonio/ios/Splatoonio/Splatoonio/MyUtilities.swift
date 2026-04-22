import UIKit
import CoreGraphics
import CoreLocation


class MyUtilities
{
	// =================================================================================
	
	class func circleImageWithColor(color:UIColor, radius:CGFloat) -> UIImage!
	{
		let size = Int(radius + radius)
		let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
		let context = CGContext(data:nil,
		                        width:size,
		                        height:size,
		                        bitsPerComponent:8,
		                        bytesPerRow:4 * size,
		                        space:colorSpace,
		                        bitmapInfo:UInt32(CGBitmapInfo.byteOrder32Little.rawValue) | UInt32(CGImageAlphaInfo.premultipliedLast.rawValue))
		
		if let c = context
		{
			c.setFillColor(color.cgColor)
			c.fillEllipse(in: CGRect(x:0, y:0, width:size, height:size))
			
			return UIImage(cgImage:c.makeImage()!)
		}
		
		return nil
	}
	
	// =================================================================================
	
	class func roundedRectImage(color:UIColor, width pointWidth:Int, height pointHeight:Int, radius r:CGFloat) -> UIImage!
	{
		let scale:CGFloat = UIScreen.main.scale
		let width:Int = Int(CGFloat(pointWidth) * scale)
		let height:Int = Int(CGFloat(pointHeight) * scale)
		let radius:CGFloat = r * scale
		let colorSpace:CGColorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
		let context:CGContext? = CGContext(data:nil,
		                                   width:width,
		                                   height:height,
		                                   bitsPerComponent:8,
		                                   bytesPerRow:4 * width,
		                                   space:colorSpace,
		                                   bitmapInfo: UInt32(CGBitmapInfo.byteOrder32Little.rawValue) |
													  UInt32(CGImageAlphaInfo.premultipliedLast.rawValue))
		
		if let c = context
		{
			let w:CGFloat = CGFloat(width)
			let h:CGFloat = CGFloat(height)
			let diameter:CGFloat = 2 * radius
			let x:[CGFloat] = [1, radius + 1, w - (diameter + 1), w - (radius + 1)]		// inset everything by 1 to avoid weird "color leakage"
			let y:[CGFloat] = [1, radius + 1, h - (diameter + 1), h - (radius + 1)]
			
			c.setFillColor(color.cgColor)
			c.fillEllipse(in: CGRect(x:x[0],	y:y[0],		width:diameter, 	height:diameter))		// topLeft
			c.fillEllipse(in: CGRect(x:x[2],	y:y[0],		width:diameter, 	height:diameter))		// topRight
			c.fillEllipse(in: CGRect(x:x[0],	y:y[2],		width:diameter, 	height:diameter))		// botLeft
			c.fillEllipse(in: CGRect(x:x[2],	y:y[2],		width:diameter, 	height:diameter))		// botRight
			c.fill(CGRect(x:x[1],	y:y[0],		width:(x[3] - x[1]),	height:h - 2))
			c.fill(CGRect(x:x[0],	y:y[1],		width:w - 2,			height:(y[3] - y[1])))
			
			if let i = c.makeImage()
			{
				return UIImage(cgImage:i)
			}
		}
		
		return nil
	}
	
	// =================================================================================
	
	static func buttonWithSize(size:CGSize) -> UIButton
	{
		let BUTTON_FONT_SIZE:CGFloat = 25
		
		let button:UIButton = UIButton(type:.custom)
		button.frame.size = size
		button.setTitleColor(.white, for:.normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize:BUTTON_FONT_SIZE)
		
		let highlightColor:UIColor = UIColor(red:0.5, green:0.5, blue:0.5, alpha:1.0)
		let normalImage:UIImage = roundedRectImage(color:.black, width:Int(size.width), height:Int(size.height), radius:5)
		let highlightImage:UIImage = roundedRectImage(color:highlightColor, width:Int(size.width), height:Int(size.height), radius:5)
		button.setBackgroundImage(normalImage, for:.normal)
		button.setBackgroundImage(highlightImage, for:.highlighted)
		
		return button
	}
	
	// =================================================================================
	
	static func metersSquared(_ prefix:String) -> NSMutableAttributedString
	{
		let font:UIFont = UIFont.systemFont(ofSize:20)
		let fontSuper:UIFont = UIFont.systemFont(ofSize:15)
		let attString:NSMutableAttributedString = NSMutableAttributedString(string:"\(prefix)m2", attributes: [NSAttributedString.Key.font:font])
		attString.setAttributes([NSAttributedString.Key.font:fontSuper, NSAttributedString.Key.baselineOffset:7], range:NSRange(location:prefix.count + 1, length:1))
		
		return attString
	}
	
	// =================================================================================
	// Returns the minimum dimensions for view that still contains all its subviews
	class func shrinkWrap(view:UIView)
	{
		var minx:CGFloat = 0
		var maxx:CGFloat = 0
		var miny:CGFloat = 0
		var maxy:CGFloat = 0
		
		for v in view.subviews
		{
			if (v.frame.minX < minx) { minx = v.frame.minX }
			if (v.frame.maxX > maxx) { maxx = v.frame.maxX }
			if (v.frame.minY < miny) { miny = v.frame.minY }
			if (v.frame.maxY > maxy) { maxy = v.frame.maxY }
		}
		
		for v in view.subviews
		{
			v.frame.origin.x -= minx
			v.frame.origin.y -= miny
		}
		
		view.frame.size = CGSize(width:maxx - minx, height:maxy - miny)
	}
	
	// =================================================================================
	// Takes any coordinate and converts it to the same location, but within normal
	// coordinate bounds: latitude in [-90, 90], and longitude in [-180, 180)
	class func normalizedGPSLocation(location:CLLocationCoordinate2D) -> CLLocationCoordinate2D
	{
		var answer:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:location.latitude, longitude:location.longitude)
		
		// correct the latitude
		if (answer.latitude > 90)
		{
			answer.latitude += 90
			let factor:Int = Int(answer.latitude / 180)
			let remaining:CLLocationDegrees = answer.latitude - CLLocationDegrees(factor * 180)
			answer.latitude = (factor % 2 == 0 ? -1.0 : 1.0) * (90 - remaining)
		}
		else if (answer.latitude < -90)
		{
			answer.latitude -= 90
			let factor:Int = Int(answer.latitude / 180)
			let remaining:CLLocationDegrees = answer.latitude - CLLocationDegrees(factor * 180)
			answer.latitude = (factor % 2 == 0 ? 1.0 : -1.0) * (90 + remaining)
		}
		
		// correct the longitude
		if (answer.longitude >= 180)
		{
			let factor:Int = Int((answer.longitude + 180) / 360)
			answer.longitude -= Double(360 * factor)
		}
		else if (answer.longitude < -180)
		{
			let factor:Int = Int((answer.longitude - 180) / 360)
			answer.longitude -= Double(360 * factor)
		}
		
		return answer;
	}
	
	// =================================================================================
	// Return IP address of WiFi interface (en0) as a String, or `nil`
	// From: https://stackoverflow.com/questions/30748480/swift-get-devices-ip-address
	// with some Swift later version fixes
	static func getWiFiAddress() -> String? {
		var address : String?
		
		// Get list of all interfaces on the local machine:
		var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
		if getifaddrs(&ifaddr) == 0 {
			
			// For each interface ...
			var ptr = ifaddr
			while ptr != nil {
				defer { ptr = ptr!.pointee.ifa_next }
				
				let interface = ptr!.pointee
				
				// Check for IPv4 or IPv6 interface:
				let addrFamily = interface.ifa_addr.pointee.sa_family
				if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
					
					// Check interface name:
					if let name = String(validatingUTF8:interface.ifa_name), name == "en0" {
						
						// Convert interface address to a human readable string:
						var hostname:[CChar] = [CChar](repeating: 0, count: Int(NI_MAXHOST))
						getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
						            &hostname, socklen_t(hostname.count),
						            nil, socklen_t(0), NI_NUMERICHOST)
						address = String(validatingUTF8:hostname)
					}
				}
			}
			freeifaddrs(ifaddr)
		}
		
		return address
	}
	
	// =================================================================================
}

// =================================================================================

extension CGPoint
{
	func distance(to:CGPoint) -> CGFloat
	{
		let xterm = self.x - to.x
		let yterm = self.y - to.y
		return sqrt((xterm * xterm) + (yterm * yterm))
	}
	
	func distanceSquared(to:CGPoint) -> CGFloat
	{
		let xterm = self.x - to.x
		let yterm = self.y - to.y
		return (xterm * xterm) + (yterm * yterm)
	}
}

// =================================================================================

extension CLLocationCoordinate2D
{
	// lat/lon degrees allowed before considering it a change in location
	// ~decimeter accuray
	private static let TOLERANCE:CLLocationDegrees = 0.000001
	
	static func == (_ one:CLLocationCoordinate2D, _ two:CLLocationCoordinate2D) -> Bool
	{
		return (abs(one.latitude - two.latitude) < TOLERANCE) &&
			(abs(one.longitude - two.longitude) < TOLERANCE)
	}
	
	static func != (_ one:CLLocationCoordinate2D, _ two:CLLocationCoordinate2D) -> Bool
	{
		return !(one == two)
	}
}





