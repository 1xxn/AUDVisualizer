import Foundation

class BubbleSort: SortingAlgorithm {
    var type: AlgorithmType {
        return .bubbleSort
    }
    
    func sort(array: [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void) {
            var arr = array
            bubbleSort(&arr, completion: completion, stepByStep: stepByStep)
        }
        
    private func bubbleSort(_ array: inout [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void) {
        
        
        for i in 0..<array.count {
            stepByStep("Starting pass \(i + 1) through the array", array)
            
            for j in 1..<array.count - i {
                let explanation = "Comparing \(array[j - 1]) and \(array[j])"
                let left = array[j - 1]
                let right = array[j]
                if left > right {
                    array.swapAt(j - 1, j)
                    stepByStep(explanation + ": \(left) is greater than \(right), so swapping them", array)

                } else {
                    stepByStep(explanation + ": They're in the correct order, so no swap needed", array)
                }
            }
        }
        stepByStep("Bubble sort complete. The array is now sorted.", array)
        completion(array)
    }

}
