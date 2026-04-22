import Foundation


struct UserStats
{
	var team:TeamColor
	var areaPainted:Int				// total area this user painted (sq m) 
	var areaStolen:Int				// enemy area this user painted over during the game (sq m) 
	var areaRemaining:Int			// area this user painted that still reamins at the end of the game (sq m) 
	
	// =================================================================================
	//									Utilities
	// =================================================================================
	
	init?(json:[String:Any])
	{
		guard let teamInt = json["team"] as? Int,
			let painted = json["painted"] as? Int,
			let stolen = json["stolen"] as? Int,
			let remaining = json["remaining"] as? Int,
			let teamColor = TeamColor(rawValue: teamInt) else { return nil }
		
		team = teamColor
		areaPainted = painted
		areaStolen = stolen
		areaRemaining = remaining
	}
}


// =================================================================================
// =================================================================================


struct GameStats
{
	// everything is in square meters
	var userStats:[UserID:UserStats]
	var remaining:[TeamColor:Int]
	var totalArea:Int
	
	// =================================================================================
	//									Utilities
	// =================================================================================
	
	init?(json:[String:Any])
	{
		guard let numTiles = json["num_tiles"] as? Int else { return nil }
		guard let users = json["user_stats"] as? [String:Any] else { return nil }
		
		userStats = [UserID:UserStats]()
		remaining = [TeamColor:Int]()
		totalArea = numTiles
		
		for (userID, value) in users
		{
			guard let intValue = Int(userID),
				let statsJson = value as? [String:Any],
				let stats = UserStats(json:statsJson) else { continue }
			
			userStats[UserID(intValue)] = stats
			remaining[stats.team] = (remaining[stats.team] ?? 0) + stats.areaRemaining
		}
	}
}
