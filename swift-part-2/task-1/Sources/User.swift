import Foundation

struct User {
    
    let username: String
    let email: String
    let password: String


    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }

    // create account without email
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.email = ""
    }
}