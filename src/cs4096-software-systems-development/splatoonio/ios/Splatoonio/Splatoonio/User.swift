import Foundation

class User : NSObject, NSCoding
{
	static let ID_NONE:UInt64 = 0		// TODO: set this to be a special "no user" value (invalid userID)
	
	var name:String = ""
	var ID:UInt64 = User.ID_NONE
	var session:String! = nil
	
	// =================================================================================
	//									Initialization
	// =================================================================================
	
	override init()
	{
		// exists to allow blank user creation (else forced to use the coder initialization)
	}
	
	// =================================================================================
	//									  NSCoding
	// =================================================================================
	
	required init?(coder aDecoder:NSCoder)
	{
		if let n = aDecoder.decodeObject(forKey:"name") as? String
		{
			name = n
		}
		if let num = aDecoder.decodeObject(forKey:"ID") as? NSNumber
		{
			ID = num.uint64Value
		}
		
		session = aDecoder.decodeObject(forKey:"session") as? String
	}
	
	// =================================================================================
	
	func encode(with aCoder: NSCoder)
	{
		aCoder.encode(name, forKey:"name")
		aCoder.encode(NSNumber(value:ID), forKey:"ID")
		aCoder.encode(session, forKey:"session")
	}
	
	// =================================================================================
}
