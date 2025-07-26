import Foundation

final class Service {

    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "my.operationQueue"
        queue.maxConcurrentOperationCount = 6
        return queue
    }()

    func add(operation: Operation) {
        queue.addOperation(operation)
    }

    func add(operations: [Operation]) {
        operations.forEach { queue.addOperation($0) }
    }
}

let operationA = BlockOperation {
    print("Operation \"A\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"A\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let operationB = BlockOperation {
    print("Operation \"B\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"B\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let operationC = BlockOperation {
    print("Operation \"C\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"C\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let operationD = BlockOperation {
    print("Operation \"D\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"D\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

let operationE = BlockOperation {
    print("Operation \"E\" started") //  here use A, B, C, D depending on which operation you are configuring
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"E\" finished") //  here use A, B, C, D depending on which operation you are configuring
}

operationB.addDependency(operationC)
operationD.addDependency(operationB)
operationA.queuePriority = .low

let service = Service()
service.add(operations: [operationA, operationB, operationC, operationD, operationE])
service.queue.waitUntilAllOperationsAreFinished()
