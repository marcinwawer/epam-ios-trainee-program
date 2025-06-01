import Foundation

class Stack<T> {

    private class Element {
        
        let value: T
        var previous: Element?

        init(value: T) {
            self.value = value
            previous = nil
        }

        deinit {
            print("deinit element with value: \(value)")
        }
    }

    private var top: Element? = nil
    private var count: Int = 0

    func size() -> Int { return count }

    func peek() -> T? { top?.value }

    func isEmpty() -> Bool { count == 0 }

    func push(_ element: T) {
        let newElem = Element(value: element)

        newElem.previous = top
        top = newElem

        count += 1
    }

    func pop() -> T? {
        guard count > 0 else { return nil }

        let elemToReturn = top

        top = elemToReturn?.previous
        elemToReturn?.previous = nil
        
        count -= 1
        return elemToReturn?.value
    }

    func printStackContents() -> String {
        var current = top
        var strValues = [String]()
        
        while let elem = current {
            strValues.append("\(elem.value)")
            current = elem.previous
        }

        return strValues.joined(separator: " <- ")
    }
}