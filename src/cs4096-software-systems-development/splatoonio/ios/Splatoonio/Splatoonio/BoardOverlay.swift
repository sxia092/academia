import Foundation
import MapKit


class BoardOverlay : NSObject, MKOverlay
{
	var board:GameBoard!
	
	// =================================================================================
	//										MKOverlay
	// =================================================================================
	
	var coordinate: CLLocationCoordinate2D
	{
//		print("overlay center=\((board.boundingRegion.center.latitude, board.boundingRegion.center.longitude))")
		return board.boundingRegion.center
	}
	
	// =================================================================================
	
	var boundingMapRect: MKMapRect
	{
//		print("bounds=\(board.boundingRegion)")
		let geoBounds = board.boundingRegion
		let topLeft = CLLocationCoordinate2DMake(geoBounds.center.latitude + (geoBounds.span.latitudeDelta / 2),
		                                         geoBounds.center.longitude - (geoBounds.span.longitudeDelta / 2))
		let botRight = CLLocationCoordinate2DMake(topLeft.latitude - geoBounds.span.latitudeDelta,
		                                          topLeft.longitude + geoBounds.span.longitudeDelta)
//		print("topleft=\((topLeft.latitude, topLeft.longitude))")
//		print("botRight=\((botRight.latitude, botRight.longitude))")
		                                          
		let origin = MKMapPoint(topLeft)
		let opposite = MKMapPoint(botRight)
		let rect = MKMapRect(x: origin.x, y: origin.y, width: opposite.x - origin.x, height: opposite.y - origin.y)
		
		return rect
	}
	
	// =================================================================================
}
