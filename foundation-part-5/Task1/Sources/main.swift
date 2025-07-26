import Foundation

final class Service {

    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "my.operationQueue"
        queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        return queue
    }()

    func add(operation: Operation) {
        queue.addOperation(operation)
    }
}

let operation = BlockOperation {
    print("Operation \"A\" started")
    for _ in 0..<1000000 {
        // do nothing
    }
    print("Operation \"A\" finished")
}

// OperationQueue.main.addOperation(operation)
// RunLoop.main.run(until: Date().addingTimeInterval(1))

let service = Service()
service.add(operation: operation)
service.queue.waitUntilAllOperationsAreFinished()
