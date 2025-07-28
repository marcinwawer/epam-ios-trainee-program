//
//  SwiftUIView.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct Task1View: View {
    let task1API = Task1API()
    @State var fact = "To get random number fact presss button below"

    var body: some View {
        VStack {
            Text(fact)
                .padding()
            Button(action: {
                Task {
                    let fact = try? await task1API.getTrivia(for: .none)
                    
                    await MainActor.run {
                        if let fact {
                            self.fact = fact
                        }
                    }
                }
            }, label: { Text("Click me") })
        }
    }
}

#Preview {
    Task1View()
}

actor Task1API {
    let baseURL = "http://numbersapi.com"
    let triviaPath = "random/trivia"
    private var session = URLSession.shared
    
    func getTrivia(for number: Int?) async throws -> String {
        guard let url = URL(string: baseURL)?.appendingPathComponent(triviaPath) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let trivia = String(data: data, encoding: .utf8)
        guard let trivia else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return trivia
    }
}

/*
class Task1API: @unchecked Sendable {
    let baseURL = "http://numbersapi.com"
    let triviaPath = "random/trivia"
    private var session = URLSession.shared

    func getTrivia(for number: Int?, completion: @Sendable @escaping (String?) -> Void) {
        guard let url = URL(string: baseURL)?.appendingPathComponent(triviaPath) else {
            completion(nil)
            return
        }
        print(url)

        session.dataTask(with: .init(url: url)) { data, response, error in
            guard let data else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            let randomFact = String(data: data, encoding: .utf8)
            DispatchQueue.main.async {
                completion(randomFact)
            }

        }.resume()
    }

}
*/
