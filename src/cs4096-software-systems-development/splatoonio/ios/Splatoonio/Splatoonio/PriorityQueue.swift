import Foundation

// uses a min heap to maintain order
class PriorityQueue<T:Comparable>
{
	private var data:[T]
	
	// =====================================================================================
	//										Initializers
	// =====================================================================================
	// Creates an empty ProiorityQueue
	init()
	{
		data = Array<T>()
	}
	
	// =====================================================================================
	//										Normal Methods
	// =====================================================================================
	// Adds an element to the queue and puts it in the right spot
	func add(_ value:T)
	{
		// put the new value at the end of the heap
		data.append(value)
		
		// if rearranging might be needed, rearrange
		if (data.count > 1)
		{
			// shift the new item (at the last index) up into the correct position
			var index = data.count - 1
			var parent = (index - 1) / 2
			
			while (parent >= 0) && (index != parent) && (data[index] < data[parent])
			{
				// swap the two items
				let temp = data[index]
				data[index] = data[parent]
				data[parent] = temp
				
				// change the indices to perform check and swap again with the new index higher in the heap
				index = parent
				parent = (index - 1) / 2
			}
		}
	}
	
	// =====================================================================================
	// Removes and returns the element at the front of the queue
	func poll() -> T?
	{
		if (data.count == 0)
		{
			return nil
		}
		
		let retValue = data[0]
		var index = 0
		
		// put the last value at the front
		data[0] = data[data.count - 1]
		data.removeLast()
		
		// shift the value in front down through the heap
		while let target = getLowestChild(parent:index)
		{
			if (data[index] > data[target])
			{
				// swap the items at index and target
				let temp = data[index]
				data[index] = data[target]
				data[target] = temp
				
				// recalculate the indices to do it all again with the new index lower in the heap
				index = target
			}
			else
			{
				break
			}
		}
		
		return retValue
	}
	
	// =====================================================================================
	// Returns the index of the lowest child for the given parent
	private func getLowestChild(parent:Int) -> Int?
	{
		let child1 = (parent * 2) + 1
		let child2 = (parent * 2) + 2
		
		if (child1 < data.count)
		{
			if (child2 < data.count)
			{
				return (data[child1] < data[child2] ? child1 : child2)
			}
			else
			{
				return child1
			}
		}
		else if (child2 < data.count)
		{
			return child2
		}
		
		return nil
	}
	
	// =====================================================================================
	// Returns the element at the front of the queue
	func peek() -> T?
	{
		return (data.count == 0) ? nil : data[0]
	}
	
	// =====================================================================================
	// Returns the number of elements in the queue
	func size() -> Int
	{
		return data.count
	}
	
	// =====================================================================================
	// Removes all elements from the queue
	func clear(keepingCapacity:Bool)
	{
		data.removeAll(keepingCapacity:keepingCapacity)
	}
	
	// =====================================================================================
	
}



