import Foundation

class MergeSort: SortingAlgorithm {
    var type: AlgorithmType {
        return .mergeSort
    }
    
    func sort(array: [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void) {
        var arr = array
        mergeSort(&arr, start: 0, end: arr.count - 1, stepByStep: stepByStep)
        completion(arr)
    }
            
    // merge sort algorithm
    func mergeSort(_ array: inout [Int], start: Int, end: Int, stepByStep: @escaping (String, [Int]) -> Void) {
        if start < end {
            let mid = (start + end) / 2
            stepByStep("Splitting the array into two: \(Array(array[start...mid])) and \(Array(array[mid+1...end]))", array)
            mergeSort(&array, start: start, end: mid, stepByStep: stepByStep)
            mergeSort(&array, start: mid + 1, end: end, stepByStep: stepByStep)
            merge(&array, start: start, mid: mid, end: end, stepByStep: stepByStep)
            
            if start == 0 && end == array.count - 1 {
                stepByStep("Merge Sort complete! The array is now in order.", array)
            }
        }
    }
    
    // helper function to merge two sorted sub-arrays into single sorted array
    func merge(_ array: inout [Int], start: Int, mid: Int, end: Int, stepByStep: @escaping (String, [Int]) -> Void) {
        let leftArray = Array(array[start...mid])
        let rightArray = Array(array[mid+1...end])
        var i = 0
        var j = 0
        var k = start
        
        
        stepByStep("Merging two sorted arrays: \(leftArray) and \(rightArray)", array)

        while i < leftArray.count && j < rightArray.count {
            if leftArray[i] < rightArray[j] {
                array[k] = leftArray[i]
                stepByStep("Taking \(leftArray[i]) from the left array as it's smaller than \(rightArray[j])", array)
                i += 1
            } else {
                array[k] = rightArray[j]
                stepByStep("Taking \(rightArray[j]) from the right array as it's smaller than \(leftArray[i])", array)
                j += 1
            }
            k += 1
        }
        
        while i < leftArray.count {
            array[k] = leftArray[i]
            stepByStep("Placing remaining element \(leftArray[i]) from the left array", array)
            i += 1
            k += 1
        }
        
        while j < rightArray.count {
            array[k] = rightArray[j]
            stepByStep("Placing remaining element \(rightArray[j]) from the right array", array)
            j += 1
            k += 1
        }
        stepByStep("Finished merging. The merged segment is: \(Array(array[start...end]))", array)
    }
}
