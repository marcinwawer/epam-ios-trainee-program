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

let operationB = BlockOperation {
    print("Operation \"B\" started") //  here use A, B depending on which operation you are configuring
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"B\" finished") //  here use A, B depending on which operation you are configuring
}

let operationA = BlockOperation {
    print("Operation \"A\" started") //  here use A, B depending on which operation you are configuring
    operationB.cancel()
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"A\" finished") //  here use A, B depending on which operation you are configuring
}

operationB.addDependency(operationA)

let service = Service()
service.add(operations: [operationA, operationB])
service.queue.waitUntilAllOperationsAreFinished()