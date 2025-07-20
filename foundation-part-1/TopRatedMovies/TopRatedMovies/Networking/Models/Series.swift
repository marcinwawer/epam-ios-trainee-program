import Foundation

struct SeriesResponse: Decodable {
    
    let page: Int
    let results: [Series]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct Series: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let originalName: String
    let overview: String
    let firstAirDate: String
    let originalLanguage: String
    let originCountry: [String]
    let genreIds: [Int]
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    let backdropPath: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName = "original_name"
        case overview
        case firstAirDate = "first_air_date"
        case originalLanguage = "original_language"
        case originCountry = "origin_country"
        case genreIds = "genre_ids"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

extension Series {
    
    func posterURL(size: String = "w500") -> URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "\(TMDBConfig.imageBaseURL)\(size)\(path)")
    }
}

extension Series {
    
    static let mock = Series(
        id: 1,
        name: "Breaking Bad",
        originalName: "Breaking Bad",
        overview: "A high school chemistry teacher turned methamphetamine producer.",
        firstAirDate: "2008-01-20",
        originalLanguage: "en",
        originCountry: ["US"],
        genreIds: [18, 80],
        popularity: 100.0,
        voteAverage: 9.5,
        voteCount: 10000,
        adult: false,
        backdropPath: "/example_backdrop.jpg",
        posterPath: "/example_poster.jpg"
    )
}
