import Foundation


// Represents an update to a single tile, for use with communication with the server
struct TileUpdate : Comparable
{
	var index:Int		// index in the board for this tile. Indices count like reading a book
	var team:TeamColor
	var timestamp:TimeInterval
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init()
	{
		index = 0
		team = .none
		timestamp = 0
	}
	
	// =================================================================================
	//									Comparisons
	// =================================================================================
	
	static func < (one:TileUpdate, two:TileUpdate) -> Bool
	{
		if (one.timestamp == two.timestamp)
		{
			if (one.index == two.index)
			{
				return one.team < two.team
			}
			return one.index < two.index
		}
		return one.timestamp < two.timestamp
	}
	
	// =================================================================================
	
	static func == (one:TileUpdate, two:TileUpdate) -> Bool
	{
		return (one.timestamp == two.timestamp) &&
				(one.index == two.index) &&
				(one.team.rawValue == two.team.rawValue)
	}
	
	// =================================================================================
}

