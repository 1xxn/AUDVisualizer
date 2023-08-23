protocol DataStructure {
    var type: DataStructureType { get }
}


enum DataStructureType: String, CaseIterable {
    case stack = "Stack"
    case linkedList = "Linked List"
}

enum StackOperation {
    case new
    case push
    case pop
    case isEmpty
}

enum LinkedListOperation {
    case search
    case insert
    case delete
    case deleteSent
}

protocol StackProtocol: DataStructure {
    func new()
    func push(k: Int)
    func pop() -> Int?
    func isEmpty() -> Bool
}

protocol LinkedListProtocol: DataStructure {
    func search(k: Int) -> LinkedListNode?
    func insert(x: LinkedListNode)
    func delete(x: LinkedListNode)
    func deleteSent(x: LinkedListNode)
}
