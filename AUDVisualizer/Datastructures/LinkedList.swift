import Foundation

class LinkedListNode {
    var key: Int
    var next: LinkedListNode?
    var prev: LinkedListNode?
    
    init(key: Int) {
        self.key = key
    }
}

class LinkedList: LinkedListProtocol {
    var type: DataStructureType {
        return .linkedList
    }
    var head: LinkedListNode?
    
    // search operation for linked lists
    func search(k: Int) -> LinkedListNode? {
        var current = head
        while current != nil && current?.key != k {
            current = current?.next
        }
        return current
    }
    
    // insert operation for linked lists
    func insert(x: LinkedListNode) {
        x.next = head
        x.prev = nil
        if head != nil {
            head?.prev = x
        }
        head = x
    }
    
    // delete operation for linked lists
    func delete(x: LinkedListNode) {
        if x.prev != nil {
            x.prev?.next = x.next
        } else {
            head = x.next
        }
        
        if x.next != nil {
            x.next?.prev = x.prev
        }
    }
    
    // deleteSent operation for linked lists
    func deleteSent(x: LinkedListNode) {
        x.prev?.next = x.next
        x.next?.prev = x.prev
    }
    
}
