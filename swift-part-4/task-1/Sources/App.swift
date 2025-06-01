import Foundation

@main
struct App {
    static func main() {
        runApp()
    }
}

fileprivate func runApp() {
    let intStack = Stack<Int>()

    print("Stack is empty: \(intStack.isEmpty())")

    intStack.push(10)
    intStack.push(20)
    intStack.push(30)

    print("Top element (peek): \(intStack.peek() ?? -1)")
    print("Stack size: \(intStack.size())")

    print(intStack.printStackContents())

    print("Popped: \(intStack.pop() ?? -1)")
    print("Popped: \(intStack.pop() ?? -1)")

    print("Top after pops: \(intStack.peek() ?? -1)")
    print("Stack size: \(intStack.size())")
    print("Stack is empty: \(intStack.isEmpty())")

    print(intStack.pop() ?? -1)
    print("Stack is empty: \(intStack.isEmpty())")
}