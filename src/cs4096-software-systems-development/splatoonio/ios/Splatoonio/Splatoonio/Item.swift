import UIKit
import CoreLocation



class Item
{
	var id:UInt64
	var location:CLLocationCoordinate2D
	
	let type:ItemType = .generic
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init()
	{
		id = 0
		location = CLLocationCoordinate2DMake(0, 0)
	}
	
	// =================================================================================
}
