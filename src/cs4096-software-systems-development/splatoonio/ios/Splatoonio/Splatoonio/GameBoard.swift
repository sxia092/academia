import Foundation
import MapKit


class GameBoard
{
	private var map:Map
	private var boardData:[Tile]
	
	// computed properties
	var width:Int                         { return map.tileWidth }
	var height:Int                        { return map.tileHeight }
	var boundingRegion:MKCoordinateRegion { return map.region }
	
	// =================================================================================
	//									Initializiers
	// =================================================================================
	
	init()
	{
		map = Map(MKCoordinateRegion(center: CLLocationCoordinate2DMake(0, 0), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0)))
		boardData = [Tile]()
	}
	
	// =================================================================================
	
	init(_ inMap:Map)
	{
		map = inMap
		boardData = [Tile](repeating:Tile(), count:map.tileWidth * map.tileHeight)
	}
	
	// =================================================================================
	//									Normal Functions
	// =================================================================================
	// Returns the updates that were actually used/applied (not out of date or for invalid tiles)
	func update(tiles:[TileUpdate]) -> [TileUpdate]
	{
		var used = [TileUpdate]()
		
		for tile in tiles
		{
			if (tile.index < boardData.count) &&
				(map.validMask[tile.index]) &&
				(boardData[tile.index].timestamp < tile.timestamp)
			{
				boardData[tile.index].team = tile.team
				used.append(tile)
			}
		}
		
		return used
	}
	
	// =================================================================================
	
	func getBoardColor(row:Int, col:Int) -> TeamColor
	{
		if (row < 0) || (row >= height) || (col < 0) || (col >= width)
		{
			print("ERROR: bad row or col value: r=\(row) c=\(col)")
		}
		
		let index = (row * width) + col
		return boardData[index].team
	}
	
	// =================================================================================
	// Returns the tile index or a negative index if out of bounds
	func tileIndexForGPSLocation(location:CLLocationCoordinate2D) -> Int
	{
		let topLeftLat:CLLocationDegrees = map.region.center.latitude + (map.region.span.latitudeDelta / 2)
		let topLeftLon:CLLocationDegrees = map.region.center.longitude - (map.region.span.longitudeDelta / 2)
		let botRightLat:CLLocationDegrees = map.region.center.latitude - (map.region.span.latitudeDelta / 2)
		let botRightLon:CLLocationDegrees = map.region.center.longitude + (map.region.span.longitudeDelta / 2)
		
		if (location.latitude < botRightLat) || (location.latitude > topLeftLat) ||
			(location.longitude < topLeftLon) || (location.longitude > botRightLon)
		{
			return -1
		}
		
		let landUnitWidth:Double = map.region.span.longitudeDelta / Double(width)
		let landUnitHeight:Double = map.region.span.latitudeDelta / Double(height)
		let row:Int = Int((topLeftLat - location.latitude) / landUnitHeight)
		let col:Int = Int((location.longitude - topLeftLon) / landUnitWidth)
		
		return (row * width) + col
	}
	
	// =================================================================================
	
	func paintPoint(at coord:CLLocationCoordinate2D, forPlayer player:Player) -> [TileUpdate]
	{
		let maxLat:CLLocationDegrees = map.region.center.latitude + (map.region.span.latitudeDelta / 2)
		let minLon:CLLocationDegrees = map.region.center.longitude - (map.region.span.longitudeDelta / 2)
		let landUnitHeight:Double = map.region.span.latitudeDelta / Double(height)
		let landUnitWidth:Double = map.region.span.longitudeDelta / Double(width)
		let centerPoint:CGPoint = CGPoint(x:(coord.longitude - minLon) / landUnitWidth,
		                                  y:(maxLat - coord.latitude) / landUnitHeight)
		
		// record what tiles were drawn to
		let timestamp:TimeInterval = Date().timeIntervalSince1970
		let tileCenterDist:CGFloat = 1.0 / UIScreen.main.scale
		var updates:[TileUpdate] = [TileUpdate]()
		
		let radiusInLandUnits:CGFloat = CGFloat(player.brushRadius) / CGFloat(Map.TILE_SIZE)
		let startr:Int = max(0,          Int(round(centerPoint.y - radiusInLandUnits)))
		let endr:Int   = min(height - 1, Int(round(centerPoint.y + radiusInLandUnits)))
		let startc:Int = max(0,          Int(round(centerPoint.x - radiusInLandUnits)))
		let endc:Int   = min(width - 1,  Int(round(centerPoint.x + radiusInLandUnits)))
		
		// Have to use variables i and j instead of range-based for loops because can't create ranges with start > end
		// Manually checking allows us to not have to check for start > end, which is convenient
		var i:Int = startr
		
		while (i < endr)
		{
			var j:Int = startc
			
			while (j < endc)
			{
				let index:Int = (i * width) + j
				
				// only process if it is a valid (paintable) tile
				if (!map.validMask[index])
				{
					continue
				}
				
				// paint the land unit if within the player's radius
				let here:CGPoint = CGPoint(x:CGFloat(j) + tileCenterDist, y:CGFloat(i) + tileCenterDist)
				let dist:CGFloat = here.distanceSquared(to:centerPoint)
				
				if (dist < CGFloat(player.brushRadius * player.brushRadius))
				{
					var update:TileUpdate = TileUpdate()
					update.team = player.team
					update.index = index
					update.timestamp = timestamp
					updates.append(update)
				}
				
				j += 1
			}
			
			i += 1
		}
		
		return updates
	}
	
	// =================================================================================
	// speed is in meters per second
	func paintLine(from fromCoord:CLLocationCoordinate2D, to toCoord:CLLocationCoordinate2D, travelTime:TimeInterval, forPlayer player:Player) -> [TileUpdate]
	{
		// get the to and from points in terms of tile rows and cols
		let maxLat:CLLocationDegrees = map.region.center.latitude + (map.region.span.latitudeDelta / 2)
		let minLon:CLLocationDegrees = map.region.center.longitude - (map.region.span.longitudeDelta / 2)
		let landUnitHeight:Double = map.region.span.latitudeDelta / Double(height)
		let landUnitWidth:Double = map.region.span.longitudeDelta / Double(width)
		let from:CGPoint = CGPoint(x:(fromCoord.longitude - minLon) / landUnitWidth,		// in tiles
		                           y:(maxLat - fromCoord.latitude) / landUnitHeight)
		let to:CGPoint = CGPoint(x:(toCoord.longitude - minLon) / landUnitWidth,			// in tiles
		                         y:(maxLat - toCoord.latitude) / landUnitHeight)
		
		// record what tiles were drawn to
		let travelDist:CGFloat = from.distance(to:to)
		let startDate:Date = Date().addingTimeInterval(-travelTime)
		let tileCenterDist:CGFloat = 1.0 / UIScreen.main.scale
		var updates:[TileUpdate] = [TileUpdate]()
		
		let minx:CGFloat = min(from.x, to.x)
		let maxx:CGFloat = max(from.x, to.x)
		let miny:CGFloat = min(from.y, to.y)
		let maxy:CGFloat = max(from.y, to.y)
		let radiusInLandUnits:CGFloat = CGFloat(player.brushRadius) / CGFloat(Map.TILE_SIZE)
		
		let startr:Int = max(0,          Int(round(miny - radiusInLandUnits)))
		let endr:Int   = min(height - 1, Int(round(maxy + radiusInLandUnits)))
		let startc:Int = max(0,          Int(round(minx - radiusInLandUnits)))
		let endc:Int   = min(width - 1,  Int(round(maxx + radiusInLandUnits)))
		
		// Have to use variables i and j instead of range-based for loops because can't create ranges with start > end
		// Manually checking allows us to not have to check for start > end, which is convenient
		var i:Int = startr
		
		while (i < endr)
		{
			var j:Int = startc
			
			while (j < endc)
			{
				let index:Int = (i * width) + j
				
				// only process if it is a valid (paintable) tile
				if (!map.validMask[index])
				{
					continue
				}
				
				// -------------------------------------------------------
				// Drop a normal to the line we are drawing and compute the distance to the endpoints
				let here:CGPoint = CGPoint(x:CGFloat(j) + tileCenterDist, y:CGFloat(i) + tileCenterDist)
				let dx:CGFloat = to.x - from.x			// distance to center line along x axis
				let dy:CGFloat = to.y - from.y			// distance to center line along y axis
				var dist:CGFloat						// distance to center line squared
				let travelx:CGFloat = dx / travelDist	// 1 unit in the direction of the `to` point along the x axis
				let travely:CGFloat = dy / travelDist	// 1 unit in the direction of the `to` point along the y axis
				let intersection:CGPoint
				
				if (dx == 0)
				{
					dist = (here.x - from.x) * (here.x - from.x)
					intersection = CGPoint(x:from.x, y:here.y)
				}
				else if (dy == 0)
				{
					dist = (here.y - from.y) * (here.y - from.y)
					intersection = CGPoint(x:here.x, y:from.y)
				}
				else
				{
					// find the point of intersection of the normal and center line
					// y = m1*x + b1 is the center line
					// y = m2*x + b2 is the normal that passes through the tile we are considering 
					let m1:CGFloat = dy / dx
					let b1:CGFloat = from.y - (m1 * from.x)
					let m2:CGFloat = -dx / dy
					let b2:CGFloat = here.y - (m2 * here.x)
					let x:CGFloat = (b2 - b1) / (m1 - m2)
					let y:CGFloat = b1 + (m1 * x)
					intersection = CGPoint(x:x, y:y)
					
					let xterm:CGFloat = here.x - intersection.x
					let yterm:CGFloat = here.y - intersection.y
					dist = (xterm * xterm) + (yterm * yterm)
					dist = here.distanceSquared(to:intersection)
				}
				
				// -------------------------------------------------------
				// compute timestamp
				// find the point on the center line that would have painted this tile most recently
				let distAhead:CGFloat = sqrt(CGFloat(player.brushRadius * player.brushRadius) - dist)
				let paintSourcePoint:CGPoint = CGPoint(x:intersection.x + (distAhead * travelx),
				                                       y:intersection.y + (distAhead * travely))
				let paintSourceDist:CGFloat = min(paintSourcePoint.distance(to:from), travelDist)
				let travelProportion:CGFloat = paintSourceDist / travelDist
				let timestamp = startDate.addingTimeInterval(travelTime * TimeInterval(travelProportion))
				
				// -------------------------------------------------------
				// if the intersection is outside the two endpoints, use the distance to the
				// closest endpoint instead of distance to center line
				if (intersection.x < minx) || (intersection.x > maxx) || (intersection.y < miny) || (intersection.y > maxy)
				{
					var xterm:CGFloat = here.x - from.x
					var yterm:CGFloat = here.y - from.y
					let fromDist:CGFloat = (xterm * xterm) + (yterm * yterm)
					
					xterm = here.x - to.x
					yterm = here.y - to.y
					let toDist:CGFloat = (xterm * xterm) + (yterm * yterm)
					
					dist = min(fromDist, toDist)
				}
				
				// -------------------------------------------------------
				// paint the land unit if within the player's radius
				if (dist < CGFloat(player.brushRadius * player.brushRadius))
				{
					var update:TileUpdate = TileUpdate()
					update.team = player.team
					update.index = index
					update.timestamp = timestamp.timeIntervalSince1970		// TODO: test timestamps
					updates.append(update)
				}
				
				j += 1
			}
			
			i += 1
		}
		
		return updates
	}
	
	// =================================================================================	
}











