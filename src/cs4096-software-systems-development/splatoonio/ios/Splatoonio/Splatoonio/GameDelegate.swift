import Foundation


// Used to notify an object of game events
protocol GameDelegate
{
	func boardUpdated(tiles:[TileUpdate])
	func gameOver(won:Bool)		// TODO: update the parameter to game results (percentage/sq meters painted per team)
}
