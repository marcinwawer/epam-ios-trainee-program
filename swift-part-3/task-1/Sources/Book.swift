import Foundation

class Book: Item, Borrowable {
    
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool

    override init(title: String, author: String) {
        isBorrowed = false
        super.init(title: title, author: author)
    }

    func borrow(returnDate: Date) -> Bool {
        guard returnDate > Date() else {
            print("Return date cannot be before borrow date. Book not borrowed.")
            return false
        }

        isBorrowed = true
        borrowDate = Date()
        self.returnDate = returnDate

        print("Book successfully borrowed. Return date \(String(describing: returnDate))")
        return true
    }
}
