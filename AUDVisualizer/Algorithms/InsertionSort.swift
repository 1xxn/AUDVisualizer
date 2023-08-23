import Foundation

class InsertionSort: SortingAlgorithm {
    var type: AlgorithmType {
        return .insertionSort
    }
    
    func sort(array: [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void) {
        var arr = array
        insertionSort(&arr, stepByStep: stepByStep)
        completion(arr)
    }
            
    // insertion sort algorithm
    func insertionSort(_ array: inout [Int], stepByStep: @escaping (String, [Int]) -> Void) {
        for i in 1..<array.count {
            let key = array[i]
            var j = i - 1
            
            stepByStep("Considering \(key) to find its correct position in the sorted segment of the array", array)

            while j >= 0 && array[j] > key {
                stepByStep("Since \(key) is smaller than \(array[j]), shifting \(array[j]) to the right", array)
                array[j + 1] = array[j]
                j = j - 1
            }
            array[j + 1] = key
            stepByStep("Inserted \(key) at its correct position", array)
        }
        stepByStep("Insertion Sort complete! The array is now in order.", array)
    }
}

