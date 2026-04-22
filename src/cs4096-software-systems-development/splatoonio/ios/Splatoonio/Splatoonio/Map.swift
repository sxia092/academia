import Foundation
import CoreLocation
import MapKit


class Map
{
	// indices into the list of corners
	static let SW:Int = 0
	static let SE:Int = 1
	static let NW:Int = 2
	static let NE:Int = 3
	
	static let TILE_SIZE:Double = 1.0	// width and height of a tile (meters)
	
	// in order of MapCorner indices -> sorted by increasing latitude, then increasing longitude
	var tileWidth:Int
	var tileHeight:Int
	var validMask:[Bool]		// validMask[tileIndex]: true if tile is valid/paintable, false otherwise
	var region:MKCoordinateRegion
	
	// =================================================================================
	//									Initializers
	// =================================================================================
	
	init()
	{
		tileWidth = 0
		tileHeight = 0
		validMask = [Bool]()
		region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(0, 0), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
	}
	
	// =================================================================================
	
	init(_ inRegion:MKCoordinateRegion)
	{
		tileWidth = 0
		tileHeight = 0
		validMask = [Bool]()
		region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(0, 0), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
		
		setBounds(inRegion)
	}
	
	// =================================================================================
	
	init?(_ json: [String:Any])
	{
		guard let corners  = json["corners"] as? [[String:Double]] else { return nil }
		guard let width	   = json["num_cols"] as? Int              else { return nil }
		guard let height   = json["num_rows"] as? Int              else { return nil }
		guard let invalids = json["invalid"] as? [Int]             else { return nil }
		
		tileWidth = width
		tileHeight = height
		validMask = [Bool](repeating:true, count:width * height)
		
		for index in invalids
		{
			validMask[index] = false
		}
		
		// create the region
		var points:[CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
		
		for c in corners
		{
			guard let lat = c["lat"] else { continue }
			guard let lon = c["lon"] else { continue }
			points.append(CLLocationCoordinate2DMake(lat, lon))
		}
		
		if (points.count != 4)
		{
			return nil
		}
		
		points.sort(by: {(one:CLLocationCoordinate2D, two:CLLocationCoordinate2D) -> Bool in
			if (one.latitude < two.latitude)
			{
				return true
			}
			return (one.latitude == two.latitude) && (one.longitude < two.longitude)
		})
		
		let halfLon = (points[Map.NE].longitude - points[Map.NW].longitude) / 2
		let halfLat = (points[Map.NE].latitude - points[Map.SE].latitude) / 2
		let center = CLLocationCoordinate2DMake(points[Map.NE].latitude - halfLat, points[Map.NE].longitude - halfLon)
		region = MKCoordinateRegion(center: center, latitudinalMeters: Double(tileHeight) * Map.TILE_SIZE, longitudinalMeters: Double(tileWidth) * Map.TILE_SIZE)
	}
	
	// =================================================================================
	//									Normal Functions
	// =================================================================================
	// Takes the given region and tweaks the dimensions slightly to make them multiples of Map.TILE_SIZE.
	// Also sets all other instance variables to match
	func setBounds(_ inRegion:MKCoordinateRegion)
	{
		let halfLon = inRegion.span.longitudeDelta / 2
		let halfLat = inRegion.span.latitudeDelta / 2
		
		let north = CLLocation(latitude:inRegion.center.latitude + halfLat, longitude:inRegion.center.longitude)
		let south = CLLocation(latitude:inRegion.center.latitude - halfLat, longitude:inRegion.center.longitude)
		let east = CLLocation(latitude:inRegion.center.latitude, longitude:inRegion.center.longitude + halfLon)
		let west = CLLocation(latitude:inRegion.center.latitude, longitude:inRegion.center.longitude - halfLon)
		
		tileWidth = Int(round(east.distance(from:west) / Map.TILE_SIZE))
		tileHeight = Int(round(north.distance(from:south) / Map.TILE_SIZE))
		validMask = [Bool](repeating:true, count:tileWidth * tileHeight)
		
		region = MKCoordinateRegion(center: inRegion.center, latitudinalMeters: Double(tileHeight) * Map.TILE_SIZE, longitudinalMeters: Double(tileWidth) * Map.TILE_SIZE)
	}
	
	// =================================================================================
}
