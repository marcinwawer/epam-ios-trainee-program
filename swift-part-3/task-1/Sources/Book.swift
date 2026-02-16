import Foundation

class Book: Item, Borrowable {
    
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool

    override init(title: String, author: String) {
        isBorrowed = false
        super.init(title: title, author: author)
    }
}
