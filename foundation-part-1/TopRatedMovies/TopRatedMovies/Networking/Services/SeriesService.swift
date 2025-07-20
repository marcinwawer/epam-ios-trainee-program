import Foundation

final class SeriesService {
    
    func fetchSeries(page: Int = 1, language: String = "en-US") async throws -> SeriesResponse {
        let queryItems = [
            URLQueryItem(name: TMDBConfig.QueryKeys.apiKey, value: KeyConstants.APIKeys.TMDBKey),
            URLQueryItem(name: TMDBConfig.QueryKeys.language, value: "\(language)"),
            URLQueryItem(name: TMDBConfig.QueryKeys.page, value: "\(page)")
        ]
        
        let response = try await NetworkingManager.request(
            host: TMDBConfig.host,
            path: TMDBConfig.Path.topRated,
            queryItems: queryItems,
            returnType: SeriesResponse.self
        )
        
        return response
    }
}
