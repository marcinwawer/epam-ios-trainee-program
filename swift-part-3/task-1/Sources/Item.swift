import Foundation

class Item: Identifiable {

    let id: String = UUID().uuidString
    let title: String
    let author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}
