import UIKit

class Leaderboard : NSObject
{
	private var scores:[Int64]
	private var precision:Int64		// number of decimal places
	
	var id:UInt64
	var title:String
	var units:String
	var names:[String]

	var numScores:Int
	{
		return scores.count
	}
	
	// =================================================================================
	//									Initializars 
	// =================================================================================
	
	init(title t:String)
	{
		id = 0
		title = t
		units = ""
		names = [String]()
		scores = [Int64]()
		precision = 0
	}
	
	// =================================================================================
	//									Normal Methods
	// =================================================================================
	
	func scoreAt(_ index:Int) -> String
	{
		if (precision == 0)
		{
			return "\(scores[index])"
		}
		return "\(scores[index] / precision).\(scores[index] % precision)"
	}
	
	// =================================================================================
	
	func add(score:Int64, forPlayer name:String)
	{
		var index = 0
		while ((index < scores.count) && (scores[index] < score))
		{
			index += 1
		}
		
		scores.insert(score, at:index)
		names.insert(name, at:index)
	}
	
	// =================================================================================
}
