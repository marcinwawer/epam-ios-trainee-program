import Foundation

struct DogService: ImageService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPhotos() async throws -> [Photo] {
        guard let url = URL(string: DogCeoConfig.imageURLString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decodedResponse =  try JSONDecoder().decode(DogResponse.self, from: data)
            return decodedResponse.message.map { Photo(id: $0) }
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
    }
}
