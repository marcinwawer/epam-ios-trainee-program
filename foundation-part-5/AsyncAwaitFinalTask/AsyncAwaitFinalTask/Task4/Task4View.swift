//
//  Task4View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 08/07/2024.
//
import SwiftUI

@MainActor @Observable
final class Task4ViewModel {
    
    private(set) var finished = false
    private(set) var ballance: Int = 1000
    
    @ObservationIgnored private let ballanceWrapper: BallanceWrapper
    
    init(balanceWrapper: BallanceWrapper = BallanceWrapper()) {
        self.ballanceWrapper = balanceWrapper
    }
    
    func startUpdate() async {
        await reset()
        
        await withTaskGroup { taskGroup in
            for _ in 0...999 {
                taskGroup.addTask {
                    await self.ballanceWrapper.decrement()
                    print(await self.ballanceWrapper.currentValue)
                }
            }
        }
        
        ballance = await ballanceWrapper.currentValue
        finished = true
    }
    
    func reset() async {
        await ballanceWrapper.reset(to: 1000)
        ballance = 1000
        finished = false
    }
}

struct Task4View: View {
    @State var vm: Task4ViewModel
    
    init(vm: Task4ViewModel = Task4ViewModel()) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            Text("Starting ballance: 1000")
            
            if vm.finished {
                Text("Final balance: \(vm.ballance)")
                Text(vm.ballance == 0 ? "Success" : "Failure")
            }
            
            Button {
                if vm.finished {
                    Task { await vm.reset() }
                } else {
                    Task { await vm.startUpdate() }
                }
            } label: {
                if vm.finished {
                    Text("Reset")
                } else {
                    Text("Start")
                }
            }
        }
    }
}

#Preview {
    Task4View()
}

class Task4ViewAPI: @unchecked Sendable {
    var ballance: Int = 1000
    
    func startUpdate() async -> Int {
        await withTaskGroup(of: Void.self) { group in
            for _ in 0...999 {
                group.addTask { [weak self] in
                    self?.ballance -= 1
                }
            }
        }
        
        return ballance
    }
}

actor BallanceWrapper {
    
    let api: Task4ViewAPI
    
    init(api: Task4ViewAPI = Task4ViewAPI()) {
        self.api = api
    }
    
    var currentValue: Int {
        api.ballance
    }
    
    func decrement() {
        api.ballance -= 1
    }
    
    func reset(to newBallance: Int) {
        api.ballance = newBallance
    }
}
