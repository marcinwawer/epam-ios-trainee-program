import Foundation

protocol ImageCache {
    
    func imageData(for url: URL) async throws -> Data
    func clearCache() throws
}
