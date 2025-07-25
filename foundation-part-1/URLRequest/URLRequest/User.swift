import Foundation

struct User: Codable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    
    struct Geo: Codable {
        let lat: String
        let lng: String
    }
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Company: Codable {
    
    let name: String
    let catchPhrase: String
    let bs: String
}
