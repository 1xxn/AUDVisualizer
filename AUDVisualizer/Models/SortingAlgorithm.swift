import Foundation

protocol SortingAlgorithm {
    var type: AlgorithmType { get }
    func sort(array: [Int], completion: @escaping ([Int]) -> Void, stepByStep: @escaping (String, [Int]) -> Void)
}
