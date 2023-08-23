import Foundation
import SwiftUI

class DataStructureViewModel: ObservableObject {
    @Published var userInput: String = ""
    @Published var currentIndex: Int = 0
    @Published var userInputIndex: Int = 0
    @Published var steps: [(elements: [Int], explanation: String)] = []
    @Published var currentStepIndex: Int = 0
    @Published var dataStructure: DataStructure = Stack(maxSize: 10) // loads as first datastructure stack
    @Published var linkedList: LinkedList = LinkedList()
    @Published var stackElements: [Int] = Array(repeating: 0, count: 10)
    @Published var linkedListElements: [Int] = []
    var elements: [Int] {
            selectedDataStructure == .stack ? stackElements : linkedListElements
        }
    
    @Published var selectedDataStructure: DataStructureType = .stack {
        didSet {
            switch selectedDataStructure {
            case .stack:
                self.dataStructure = Stack(maxSize: 10)
                self.stackElements = Array(repeating: 0, count: 10)
            case .linkedList:
                self.linkedList = LinkedList()
                self.linkedListElements = []
            }
        }
    }
    
    func performOperation(operation: StackOperation, value: Int? = nil) {
        guard let stack = dataStructure as? Stack else { return }
            var explanation = ""
            switch operation {
            case .new:
                stack.new()
                explanation = "Initialized a new stack with a maximum size of \(stack.MAX). The stack is now empty."
                currentIndex = 0
                userInput = ""
            case .push:
                if let value = Int(userInput) { // convert the user input to int
                            stack.push(k: value)
                    explanation = "Pushing \(value) onto the stack. This element is now at the top of the stack."
                            userInput = ""
                        } else {
                            explanation = "Please enter a valid number to push onto the stack."
                        }
            case .pop:
                if let poppedValue = stack.pop() {
                    explanation = "Popping \(poppedValue) from the stack. This element was at the top and is now removed."
                } else {
                    explanation = "Underflow error: Attempted to pop from an empty stack."
                }
            case .isEmpty:
                let isEmpty = stack.isEmpty()
                explanation = isEmpty ? "The stack is empty. There are no elements inside." : "The stack contains elements and is not empty."
            }

            if let stack = dataStructure as? Stack {
                self.stackElements = stack.A
                self.steps.append((elements: stack.A, explanation: explanation))
                self.currentStepIndex = self.steps.count - 1
            }
        }
    
    func performLinkedListOperation(operation: LinkedListOperation, value: Int? = nil) {
            var explanation = ""
            var elements: [Int] = [] // To store the linked list as an array for visualization

            switch operation {
            case .search:
                if let value = value, let _ = linkedList.search(k: value) {
                    explanation = "Found node with key \(value)."
                } else {
                    explanation = "Node not found."
                }
            case .insert:
                if let value = value {
                    let node = LinkedListNode(key: value)
                    linkedList.insert(x: node)
                    explanation = "Inserted node with key \(value)."
                }
            case .delete:
                if let value = value, let node = linkedList.search(k: value) {
                    linkedList.delete(x: node)
                    explanation = "Deleted node with key \(value)."
                } else {
                    explanation = "Node not found."
                }
            case .deleteSent:
                if let value = value, let node = linkedList.search(k: value) {
                    linkedList.deleteSent(x: node)
                    explanation = "Deleted node with key \(value) using deleteSent."
                } else {
                    explanation = "Node not found."
                }
            }

            // Convert the linked list to an array for visualization
            var current = linkedList.head
            while current != nil {
                elements.append(current!.key)
                current = current?.next
            }

            // Update elements for visualization
            self.linkedListElements = elements
            self.steps.append((elements: self.elements, explanation: explanation))
            self.currentStepIndex = self.steps.count - 1
        }
    
    
    func getExplanation(operation: StackOperation, value: Int?) -> String {
            switch operation {
            case .new:
                return "Creating a new stack."
            case .push:
                return "Pushing \(value ?? 0) onto the stack."
            case .pop:
                return "Popping the top element from the stack."
            case .isEmpty:
                return "isempty."
            }
        }

        func parseUserInput() {
            let numbers = self.userInput.split(separator: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
                if selectedDataStructure == .stack {
                    self.stackElements = numbers
                } else if selectedDataStructure == .linkedList {
                    self.linkedListElements = numbers
            }
        }

        func generateRandomNumbers() {
            let randomNumbers = (0..<10).map { _ in Int.random(in: 1...100) }
                if selectedDataStructure == .stack {
                    self.stackElements = randomNumbers
                } else if selectedDataStructure == .linkedList {
                    self.linkedListElements = randomNumbers
                }
                self.userInput = randomNumbers.map(String.init).joined(separator: ", ")
                self.currentIndex = 0 // reset the index
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
}
