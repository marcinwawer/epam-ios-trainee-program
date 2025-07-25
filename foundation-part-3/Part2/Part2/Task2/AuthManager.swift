import SwiftUI
import Observation

@Observable
final class AuthManager {
    
    private let emailKey = "userEmail"
    private let loginKey = "isLoggedIn"
    
    var email: String? {
        didSet {
            if let email {
                UserDefaults.standard.set(email, forKey: emailKey)
            } else {
                UserDefaults.standard.removeObject(forKey: emailKey)
            }
        }
    }
    
    var isLoggedIn: Bool {
        didSet { UserDefaults.standard.set(isLoggedIn, forKey: loginKey) }
    }
    
    init() {
        self.email = UserDefaults.standard.string(forKey: emailKey)
        self.isLoggedIn = UserDefaults.standard.bool(forKey: loginKey)
    }
    
    func login(email: String) {
        self.email = email
        self.isLoggedIn = true
    }
    
    func logout() {
        self.email = nil
        self.isLoggedIn = false
    }
}
