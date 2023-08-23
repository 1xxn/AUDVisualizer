import Foundation

class QuickSort: SortingAlgorithm {
    var type: AlgorithmType {
        return .quickSort
    }
    
    func sort(array: [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void) {
        var arr = array
        quickSort(&arr, start: 0, end: arr.count - 1, stepByStep: stepByStep)
        completion(arr)
    }
            
    // quick sort algorithm
    func quickSort(_ array: inout [Int], start: Int, end: Int, stepByStep: @escaping (String, [Int]) -> Void) {
        if start < end {
            let p = partition(&array, start: start, end: end, stepByStep: stepByStep)
            stepByStep("Finished partitioning around pivot. Now sorting left and right sub-arrays.", array)
            quickSort(&array, start: start, end: p, stepByStep: stepByStep)
            quickSort(&array, start: p + 1, end: end, stepByStep: stepByStep)
            
            // Checking if the entire array is sorted
            if start == 0 && end == array.count - 1 {
                stepByStep("Quick Sort complete! The array is now sorted.", array)
            }
        }
    }
        
    // helper function to select a pivot and partition the array around it
    func partition(_ array: inout [Int], start: Int, end: Int, stepByStep: @escaping (String, [Int]) -> Void) -> Int {
        let pivot = array[start]
        var i = start - 1
        var j = end + 1
        
        stepByStep("Starting partition. Chosen \(pivot) as the pivot.", array)

        while true {
            repeat { i += 1 } while array[i] < pivot
            repeat { j -= 1 } while array[j] > pivot
            
            if i < j {
                stepByStep("Swapping \(array[i]) and \(array[j])", array)
                array.swapAt(i, j)
            } else {
                stepByStep("Partitioned around \(pivot)", array)
                return j
            }
        }
    }
}
