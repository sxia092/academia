import UIKit
import MapKit


class GameMapView: MKMapView, MKMapViewDelegate
{
	// how many seconds minumum between each call to game.move()
	private static let MIN_MOVE_INTERVAL:TimeInterval = 0.5
	private static let MAP_UPDATE_INTERVAL:TimeInterval = 0.03
	
	var game:Game!
	var boardOverlay:BoardOverlay!
	var boardRenderer:BoardOverlayRenderer!
	
	private var timer:Timer!				// manages updating our location
	private var prevLocation:CLLocation?
	private var lastMove:Date
	
	// =================================================================================
	//								  Initializers
	// =================================================================================
	
	init?(game newGame:Game)
	{
		lastMove = Date()
		
		super.init(frame:CGRect.zero)
		
		game = newGame
		boardOverlay = BoardOverlay()
		boardOverlay.board = game.board
		
		guard let renderer = BoardOverlayRenderer(boardOverlay:boardOverlay) else		// must initialize with an overlay or it won't draw
		{
			print("ERROR: Could not create overlay renderer")
			return nil
		}
		
		boardRenderer = renderer
		boardRenderer.gameBoard = game.board

		self.addOverlay(boardOverlay)
		self.initializeMapSettings()
		self.syncRendererWithBoard()
	}

	// Walks the board's current tile colors and pushes them into the renderer's
	// bitmap. Used when the board has been prefilled before the view existed
	// (e.g. demo mode seeds paint in ServerAPI before the game view controller
	// is ever instantiated, so the renderer would otherwise start out blank).
	private func syncRendererWithBoard()
	{
		var updates = [TileUpdate]()
		for row in 0..<game.board.height
		{
			for col in 0..<game.board.width
			{
				let color = game.board.getBoardColor(row:row, col:col)
				if color != .none
				{
					var u = TileUpdate()
					u.index = (row * game.board.width) + col
					u.team = color
					u.timestamp = 1     // non-zero; renderer only reads team + index
					updates.append(u)
				}
			}
		}
		if !updates.isEmpty
		{
			boardRenderer.updateTiles(updates)
		}
	}
	
	// =================================================================================
	
	required init?(coder aDecoder: NSCoder)
	{
		print("ERROR: GameMapView.initWithCoder() should not be called")
		lastMove = Date()
		super.init(coder:aDecoder)
		self.initializeMapSettings()
	}
	
	// =================================================================================
	
	func initializeMapSettings()
	{
		// for simulator and testing
		if (AppData.USE_DEVICE_LOCATION)
		{
			if let coord = GPSManager.defaultManager().location()
			{
				let region = MKCoordinateRegion(center: coord, latitudinalMeters: 200, longitudinalMeters: 140)
				self.setRegion(region, animated:true)
			}
		}
		else
		{
			// Demo: visible region matches the paintable board exactly, so
			// the whole atlas fills the screen with no dead margin and the
			// S&T campus (the atlas's center) ends up centered in the frame.
			self.setRegion(game.board.boundingRegion, animated:false)
		}
		
		self.delegate = self
		self.isScrollEnabled = false
		self.isPitchEnabled = true
		self.isZoomEnabled = true
		self.isRotateEnabled = true
		self.showsCompass = false
		self.showsTraffic = false
		self.showsUserLocation = true
		self.showsPointsOfInterest = false
		
		timer = Timer.scheduledTimer(timeInterval:GameMapView.MAP_UPDATE_INTERVAL,
		                             target:self,
		                             selector:#selector(updateLocation(_:)),
		                             userInfo:nil,
		                             repeats:true)
	}
	
	// =================================================================================
	//								Location Updating
	// =================================================================================
	// Updates the heading and our location on the map to reflect the user's location and heading
	@objc func updateLocation(_:Timer)
	{
		let gps = GPSManager.defaultManager()
		
		if let loc = gps.location()
		{
			self.centerCoordinate = loc
			
			if  let me = self.game.me,
				let to = gps.currentLocation,
				AppData.USE_DEVICE_LOCATION
			{
				let now = Date()
				
				if (now.timeIntervalSince(lastMove) >= GameMapView.MIN_MOVE_INTERVAL)
				{
					game.move(player:me.id, to:to)
					lastMove = now
				}
			}
		}
		
		if let heading = gps.heading()
		{
			self.camera.heading = heading
		}
		
		self.setNeedsDisplay()
	}
	
	// =================================================================================
	//								MKMapViewDelegate
	// =================================================================================
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
	{
		return boardRenderer
	}
	
	// =================================================================================
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
	{
		if (annotation === mapView.userLocation)		// pointer/reference check, not equality
		{
			let annotationView = MKAnnotationView(annotation:annotation, reuseIdentifier:"customUserLocation")
			annotationView.image = nil
			
			return annotationView
		}
		
		// use the default annotation
		return nil
	}
	
	// =================================================================================
}













