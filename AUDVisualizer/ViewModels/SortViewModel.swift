import SwiftUI

class SortViewModel: ObservableObject {
    @Published var algorithm: SortingAlgorithm = BubbleSort()
    @Published var array: [Int] = []
    @Published var sortedArray: [Int] = []
    @Published var userInput: String = ""
    @Published var steps: [(array: [Int], explanation: String)] = []
    @Published var currentStepIndex: Int = 0
    @Published var currentStep: String = ""
    @Published var stepByStepMode: Bool = false
    @Published var selectedAlgorithm: AlgorithmType = .bubbleSort {
        didSet {
            switch selectedAlgorithm {
            case .bubbleSort:
                self.algorithm = BubbleSort()
            case .insertionSort:
                self.algorithm = InsertionSort()
            case .mergeSort:
                self.algorithm = MergeSort()
            case .quickSort:
                self.algorithm = QuickSort()
            case .radixSort:
                self.algorithm = RadixSort()
            }
            // deactivate step-by-step mode when the algorithm changes
            self.stepByStepMode = false
            // reset the steps and current step index
            self.steps = []
            self.currentStepIndex = 0
        }
    }
    
    func sort() {
        self.steps = [] // clear previous steps
        self.currentStepIndex = 0 // Reset the current step index
        self.algorithm.sort(array: self.array, completion: { sortedArray in
            DispatchQueue.main.async {
                self.sortedArray = sortedArray
            }
        }, stepByStep: { explanation, array in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 0.5-second delay
                self.steps.append((array: array, explanation: explanation))
                if self.stepByStepMode {
                    self.currentStepIndex = self.steps.count - 1
                }
            }
        })
    }
    
    func nextStep() {
        if currentStepIndex < steps.count - 1 {
            withAnimation {
                currentStepIndex += 1
            }
        }
    }
    
    func previousStep() {
        if currentStepIndex > 0 {
            withAnimation {
                currentStepIndex -= 1
            }
        }
    }
    
    func parseUserInput() {
        let numbers = self.userInput.split(separator: ",")
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
        self.array = numbers
    }
    
    func generateRandomNumbers() {
        self.array = (0..<10).map { _ in Int.random(in: 1...100) }
        self.userInput = self.array.map(String.init).joined(separator: ", ")
    }
}

