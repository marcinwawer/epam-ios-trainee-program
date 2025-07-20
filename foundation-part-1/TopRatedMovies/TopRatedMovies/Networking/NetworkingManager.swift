import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case decodingFailed
    case missingAPIKey
}

final class NetworkingManager {
    
    static var session = URLSession.shared
    
    private static func buildRequest(
        scheme: String,
        host: String,
        path: String,
        method: String,
        queryItems: [URLQueryItem]?,
        headers: [String: String]?
    ) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        guard let queryItems = queryItems,
              let apiKeyItem = queryItems.first(where: { $0.name == "api_key" }),
              let apiKey = apiKeyItem.value,
              !apiKey.isEmpty
        else {
            throw NetworkError.missingAPIKey
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
    
    static func request<T: Decodable>(
        host: String,
        path: String,
        method: String = "GET",
        queryItems: [URLQueryItem]? = nil,
        headers: [String: String]? = nil,
        returnType: T.Type
    ) async throws -> T {
        let request = try buildRequest(
            scheme: "https",
            host: host,
            path: path,
            method: method,
            queryItems: queryItems,
            headers: headers
        )
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
