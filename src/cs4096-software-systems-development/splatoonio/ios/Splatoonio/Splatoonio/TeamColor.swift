import Foundation

// TODO: convert to use UInt8's
enum TeamColor : Int, Comparable
{
	case none = 0
	
	case red
	case green
	case blue
	
	case count
	
	// =================================================================================
	
	func color() -> PaintColor
	{
		switch (self)
		{
		case .red:		return PaintColor(255, 0,   0,   255)
		case .green:	return PaintColor(0,   255, 0,   255)
		case .blue:		return PaintColor(0,   0,   255, 255)
		default:		return PaintColor(0,   0,   0,   0)
		}
	}
	
	// =================================================================================
	
	func description() -> String
	{
		switch (self)
		{
		case .red:		return "Red"
		case .green:	return "Green"
		case .blue:		return "Blue"
		case .none:		return "None"
		case .count:	return "Count"
		}
	}
	
	// =================================================================================
	//									Comparable
	// =================================================================================
	
	static func < (one:TeamColor, two:TeamColor) -> Bool
	{
		return one.rawValue < two.rawValue
	}
	
	// =================================================================================
	
	static func == (one:TeamColor, two:TeamColor) -> Bool
	{
		return one.rawValue == two.rawValue
	}
	
	// =================================================================================
	
}
