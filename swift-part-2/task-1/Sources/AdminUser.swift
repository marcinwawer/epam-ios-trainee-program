class AdminUser: UserManager {
    
    func listAllUsers() -> [String] {
        return Array(users.keys)
    }


    deinit {
        print("admin instance removed from memory, admin's users:")
        print(users)
    }
}