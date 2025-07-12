//
//  ContentView.swift
//  URLRequest
//
//  Created by Marcin Wawer on 12-07-2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var emails: [String] = []
    
    var body: some View {
        NavigationStack {
            List(emails, id: \.self) { email in
                Label(email, systemImage: "envelope.fill")
            }
            .navigationTitle("Email List")
        }
        .task {
            let result = try? await fetchAllUsersEmails()
            emails = result ?? []
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

// MARK: - CONSTANTS
extension ContentView {
    
    private enum Constants {
        static let usersURLString = "https://jsonplaceholder.typicode.com/users"
    }
}

// MARK: - FUNCS
extension ContentView {
    
    func fetchAllUsersEmails(from urlString: String = Constants.usersURLString) async throws -> [String] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode([User].self, from: data).map { $0.email }
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
}
