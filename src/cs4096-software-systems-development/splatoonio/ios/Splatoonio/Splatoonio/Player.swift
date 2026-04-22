import Foundation
import CoreLocation


class Player
{
	static let INITIAL_BRUSH_RADIUS:Float = 3.0
	
	private var loc:CLLocation?
	
	var id:PlayerID
	var team:TeamColor
	var brushRadius:Float		// in meters
	var distance:Double
	var name:String
	var location:CLLocation?
	{
		get
		{
			return loc;
		}
		set
		{
			if let old = loc, let new = newValue
			{
				distance += new.distance(from:old)
			}
			loc = newValue
		}
	}
	
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init()
	{
		id = 0
		team = .none
		brushRadius = Player.INITIAL_BRUSH_RADIUS
		distance = 0
		loc = nil
		name = ""
	}
	
	// =================================================================================
}
