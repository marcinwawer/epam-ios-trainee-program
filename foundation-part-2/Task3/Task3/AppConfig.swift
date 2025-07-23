import Foundation

struct AppConfig: Decodable {
    
    let numberOfImages: Int
    let gridColumns: Int
    let gridName: String
}

protocol ConfigLoader {
    
    func loadConfig() throws -> AppConfig
}
