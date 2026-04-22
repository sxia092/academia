import UIKit


typealias AchievementClassID = UInt64


class AchievementClass
{
	var id:AchievementClassID
	
	// current count of whatever this class is measuring (if play games achievements, then progress == num games played)
	var progress:Int
	
	// always in sorted order by rank - do not write to this
	var achievements:[Achievement]
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init(id ID:AchievementClassID)
	{
		id = ID
		progress = 0
		achievements = [Achievement]()
	}
	
	// =================================================================================
	//									Normal Functions
	// =================================================================================
	
	func addAchievement(_ achievement:Achievement)
	{
		var i = 0
		
		while (i < achievements.count) && (achievements[i].goalCount < achievement.goalCount)
		{
			i += 1
		}
		
		achievements.insert(achievement, at:i)
	}
	
	// =================================================================================
	
	func achievementForID(id:AchievementID) -> Achievement?
	{
		for a in achievements
		{
			if (a.id == id)
			{
				return a
			}
		}
		
		return nil
	}
	
	// =================================================================================
}
