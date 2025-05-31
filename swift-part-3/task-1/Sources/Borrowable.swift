import Foundation

protocol Borrowable {

    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }

    mutating func checkIn()
    
    func borrow(returnDate: Date) -> Bool
}

extension Borrowable {

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
