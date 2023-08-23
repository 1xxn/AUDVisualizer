import Foundation

class Stack: StackProtocol {
    var type: DataStructureType {
        return .stack
    }
    
    var A: [Int] = []
    let MAX: Int
    var top: Int = -1
    
    init(maxSize: Int) {
        self.MAX = maxSize
        self.A = Array(repeating: 0, count: maxSize)
    }
    
    func new() {
        self.A = Array(repeating: 0, count: MAX)
        self.top = -1
    }
    
    func isEmpty() -> Bool {
        return top < 0
    }
    
    func push(k: Int) {
        if top == MAX - 1 {
            print("Error: overflow")
        } else {
            top += 1
            A[top] = k
        }
    }
    
    func pop() -> Int? {
        if isEmpty() {
            print("Error: underflow")
            return nil
        } else {
            let value = A[top]
            A[top] = 0 // Set the popped element to zero
            top -= 1
            return value
        }
    }
}
