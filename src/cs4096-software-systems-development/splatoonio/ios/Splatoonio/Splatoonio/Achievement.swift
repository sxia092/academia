import UIKit


typealias AchievementID = UInt64


class Achievement : CustomStringConvertible
{
	var id:AchievementID
	var classID:AchievementClassID
	var title:String
	var descriptionText:String
	var goalCount:Int
	var currentCount:Int
	
	var percentComplete:CGFloat
	{
		return CGFloat(currentCount) / CGFloat(goalCount)
	}
	var completed:Bool
	{
		return (currentCount >= goalCount)
	}
	var description:String
	{
		return "\(title): \(currentCount)/\(goalCount)"
	}
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init(id ID:AchievementID, classID ID2:AchievementClassID, title t:String, description d:String, goal:Int)
	{
		id = ID
		classID = ID2
		title = t
		descriptionText = d
		goalCount = goal
		currentCount = 0
	}
	
	// =================================================================================
	//									Normal Functions
	// =================================================================================
	
	func loadMetadataFromAchievement(_ a:Achievement)
	{
		title = a.title
		descriptionText = a.description
		goalCount = a.goalCount
	}
	
	// =================================================================================
}
