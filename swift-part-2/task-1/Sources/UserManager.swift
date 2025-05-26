class UserManager {

    var users: [String: User]

    var userCount: Int {
        users.count
    }


    init() {
        self.users = [:]
    }


    deinit {
        print("usermanager instance removed from memory, usermanager's users:")
        print(users)
    }


    func registerUser(username: String, email: String, password: String) -> Bool {
        guard validateUsername(username) else { return false }
        guard validateEmail(email) else { return false }
        guard validatePassword(password) else { return false }
        
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser

        print("user \(username) successfully registered")
        return true
    }

    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("user with \(username) does not exist")
            return false
        }

        if user.password == password {
            print("successfully logged in")
            return true
        }

        print("wrong password, try again")
        return false
    }

    func removeUser(username: String) -> Bool {
        return users.removeValue(forKey: username) != nil
    }
}


// VALIDATION FUNCS
extension UserManager {

    private func validateUsername(_ username: String) -> Bool {
        guard !username.isEmpty else {
            print("username cannot be empty")
            return false
        }

        guard !users.keys.contains(username) else {
            print("user with username \(username) already exists")
            return false
        }

        // proper username validation ...

        return true
    }


    private func validateEmail(_ email: String) -> Bool {
        guard !email.isEmpty else {
            print("email cannot be empty")
            return false
        }

        // proper email validation ...

        return true
    }

    private func validatePassword(_ password: String) -> Bool {
        guard !password.isEmpty else {
            print("password cannot be empty")
            return false
        }

        // proper password validation ...

        return true
    }
}