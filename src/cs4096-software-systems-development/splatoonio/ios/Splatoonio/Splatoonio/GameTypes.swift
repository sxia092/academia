import UIKit


typealias GameID = UInt64
typealias PlayerID = UInt64
typealias UserID = UInt64
typealias MapID = UInt64

// =================================================================================

enum LobbyID
{
	case lobby(UInt64)
	case none
}

// =================================================================================

struct Tile
{
	var team:TeamColor = .none
	var timestamp:TimeInterval = 0
}

// =================================================================================

struct PaintColor
{
	var r:UInt8
	var g:UInt8
	var b:UInt8
	var a:UInt8
	var description:String
	{
		return "(\(r), \(g), \(b))"
	}
	
	init(_ inr:UInt8, _ ing:UInt8, _ inb:UInt8)
	{
		r = inr
		g = ing
		b = inb
		a = 255
	}
	
	init(_ inr:UInt8, _ ing:UInt8, _ inb:UInt8, _ ina:UInt8)
	{
		r = inr
		g = ing
		b = inb
		a = ina
	}
	
	func uicolor() -> UIColor
	{
		let red = CGFloat(r) / 255
		let green = CGFloat(g) / 255
		let blue = CGFloat(b) / 255
		return UIColor(red:red, green:green, blue:blue, alpha:1.0)
	}
}

// =================================================================================
//									ItemType
// =================================================================================

enum ItemType : Int
{
	case generic = 0
	case bomb
	case greenShell
	
	case count
	case none
	
	// =================================================================================
	
	func name() -> String
	{
		switch (self)
		{
			case .generic:		return "Generic Item"
			case .bomb:			return "Bomb"
			case .greenShell:	return "Green Shell"
			default:			return "ERROR: bad item type"
		}
	}
	
	// =================================================================================
	
	func icon() -> UIImage!
	{
		switch (self)
		{
			case .generic:		return UIImage(named:"blueSplat.png")!
			case .bomb:			return UIImage(named:"redSplat.png")!
			case .greenShell:	return UIImage(named:"greenSplat.png")!
			default:			print("ERROR: no image for item type \(self)")
		}
		
		return nil
	}
	
	// =================================================================================
}






