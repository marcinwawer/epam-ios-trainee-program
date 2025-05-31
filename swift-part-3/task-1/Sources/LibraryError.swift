import Foundation

enum LibraryError: Error {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
    case alreadyAdded
    case pastReturnDate
}