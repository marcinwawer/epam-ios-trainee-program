//
//  Task2View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

internal typealias FetchResult = (user: Task2API.User, products: [Task2API.Product])
internal typealias FetchPart = (user: Task2API.User?, products: [Task2API.Product]?)

@MainActor @Observable
final class Task2ViewModel {
    
    private(set) var user: Task2API.User?
    private(set) var products: [Task2API.Product]
    private(set) var duration: TimeInterval?
    
    @ObservationIgnored private let api: Task2API
    
    init(user: Task2API.User? = nil, products: [Task2API.Product] = [], duration: TimeInterval? = nil, api: Task2API = Task2API()) {
        self.user = user
        self.products = products
        self.duration = duration
        self.api = api
    }
    
    func fetchAll() async {
        let start = Date()
        
        do {
            let fetchResult = try await withThrowingTaskGroup(of: FetchPart.self) { taskGroup -> FetchResult in
                taskGroup.addTask {
                    let user = try await self.api.getUser()
                    return (user, nil)
                }
                
                taskGroup.addTask {
                    let products = try await self.api.getProducts()
                    return (nil, products)
                }
                
                var fetchedUser: Task2API.User?
                var fetchedProducts: [Task2API.Product]?
                
                for try await result in taskGroup {
                    if let user = result.user { fetchedUser = user }
                    if let products = result.products { fetchedProducts = products }
                }
                
                guard let user = fetchedUser,
                      let products = fetchedProducts
                else {
                    throw URLError(.badServerResponse)
                }
                
                return (user, products)
            }
            
            user = fetchResult.user
            products = fetchResult.products
            self.duration = Date().timeIntervalSince(start)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Task2View: View {

    @State var vm: Task2ViewModel
    
    init(vm: Task2ViewModel = Task2ViewModel()) {
        self.vm = vm
    }

    var body: some View {
        VStack {
            if let user = vm.user, !vm.products.isEmpty, let duration = vm.duration {
                Text("User name: \(user.name)").padding()
                List(vm.products) { product in
                    Text("product description: \(product.description)")
                }
                Text("it took: \(duration) second(s)")
            } else {
                Text("Loading in progress")
            }
        }.task {
            await vm.fetchAll()
        }
    }
}

class Task2API: @unchecked Sendable {
    struct User {
        let name: String
    }

    struct Product: Identifiable {
        let id: String
        let description: String
    }

    func getUser() async throws -> User {
        try await Task.sleep(for: .seconds(1))
        return .init(name: "John Smith")
    }

    func getProducts() async throws -> [Product] {
        try await Task.sleep(for: .seconds(1))
        return [.init(id: "1", description: "Some cool product"),
                .init(id: "2", description: "Some expensive product")]
    }
}

#Preview {
    Task2View()
}
