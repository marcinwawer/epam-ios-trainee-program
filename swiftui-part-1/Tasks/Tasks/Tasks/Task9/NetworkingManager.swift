import Foundation
import Combine

protocol Networking {
    
    func download(for url: URL) -> AnyPublisher<Data, Error>
}

struct NetworkingManager: Networking {
    
    func download(for url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try self.handleURLResponse(output: $0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else { throw URLError(.badServerResponse) }
        
        return output.data
    }
}

extension NetworkingManager {
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
