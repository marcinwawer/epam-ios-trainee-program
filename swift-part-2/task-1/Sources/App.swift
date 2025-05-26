import Foundation

@main
struct App {
    static func main() {
        runApp()
    }
}

fileprivate func runApp() {
    let userManager = UserManager()

    print(userManager.registerUser(username: "alice", email: "alice@example.com", password: "secret123"))
    print(userManager.registerUser(username: "bob", email: "bob@example.com", password: "pa$$w0rd"))
    print(userManager.registerUser(username: "alice", email: "alice2@example.com", password: "newsecret")) 
    print()

    print(userManager.login(username: "bob", password: "pa$$w0rd")) 
    print(userManager.login(username: "bob", password: "wrong")) 
    print()

    print(userManager.removeUser(username: "alice"))
    print(userManager.removeUser(username: "alice")) 
    print()

    print("current user count:", userManager.userCount)
    print()

    let admin = AdminUser()
    print(admin.registerUser(username: "eve", email: "eve@example.com", password: "pw123"))
    print(admin.registerUser(username: "dave", email: "dave@example.com", password: "pw456"))
    print()

    print(admin.listAllUsers())
}