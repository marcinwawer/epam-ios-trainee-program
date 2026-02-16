import Foundation

protocol Borrowable {

    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }

    mutating func checkIn()
    mutating func borrow(returnDate: Date) -> Bool
}

extension Borrowable {

    mutating func borrow(returnDate: Date) -> Bool {
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

    func isOverdue() -> Bool {
        guard let returnDate else { return false }
        return Date() > returnDate
    }

    mutating func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}
