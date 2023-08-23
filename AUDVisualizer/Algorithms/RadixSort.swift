import Foundation

class RadixSort: SortingAlgorithm {
    var type: AlgorithmType {
        return .radixSort
    }
    
    func sort(array: [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void) {
        var arr = array
        radixSort(&arr, stepByStep: stepByStep)
        completion(arr)
    }
    
    private func radixSort(_ array: inout [Int], stepByStep: @escaping (String, [Int]) -> Void) {
        let d = getMaxDigits(array)
        let D = 10
        
        var buckets: [[Int]] = Array(repeating: [], count: D)
        
        stepByStep("Starting Radix Sort. The array will be sorted in \(d) passes, one for each digit position.", array)

        
        for i in 0..<d {
            stepByStep("Pass \(i + 1): Sorting based on digit at position \(i + 1).", array)
            for j in 0..<array.count {
                putBucket(array, &buckets, i, j)
                let digit = getDigit(array[j], i)
                stepByStep("\(array[j]) has a digit \(digit) at position \(i + 1). Placing it in bucket \(digit).", array)

            }
            var a = 0
            for k in 0..<D {
                for b in 0..<buckets[k].count {
                    array[a] = buckets[k][b]
                    a += 1
                    stepByStep("Taking \(buckets[k][b]) from bucket \(k) and placing it back into the main array.", array)
                }
                buckets[k].removeAll()
            }
        }
        stepByStep("Radix Sort complete. The array is now sorted.", array)
    }
    
    private func putBucket(_ array: [Int], _ buckets: inout [[Int]], _ i: Int, _ j: Int) {
        let digit = getDigit(array[j], i)
        buckets[digit].append(array[j])
    }
    
    private func getDigit(_ number: Int, _ position: Int) -> Int {
        let divisor = Int(pow(10.0, Double(position)))
        return (number / divisor) % 10
    }
    
    private func getMaxDigits(_ array: [Int]) -> Int {
        var maxDigits = 0
        for num in array {
            let numDigits = Int(log10(Double(abs(num)))) + 1
            maxDigits = max(maxDigits, numDigits)
        }
        return maxDigits
    }
}
