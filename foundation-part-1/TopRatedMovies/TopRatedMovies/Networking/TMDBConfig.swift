import Foundation

struct TMDBConfig {
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/"
    static let scheme = "https"
    static let host = "api.themoviedb.org"
    
    enum Path {
        static let topRated = "/3/tv/top_rated"
    }
    
    enum QueryKeys {
        static let apiKey = "api_key"
        static let language = "language"
        static let page = "page"
    }
}
