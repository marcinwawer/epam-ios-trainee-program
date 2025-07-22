import Foundation

protocol ImageService {
    
    func fetchPhotos() async throws -> [Photo]
}
