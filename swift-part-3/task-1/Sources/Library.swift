import Foundation

class Library {

    private var items = [String: Item]()

    func addBook(_ book: Book) throws {
        if items[book.id] == nil {
            items[book.id] = book
            print("Book successfully added.")
        } else {
            throw LibraryError.alreadyAdded
        }
    }

    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else { 
            throw LibraryError.itemNotFound 
        }

        guard var borrowable = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }

        if borrowable.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }

        // no need for that optional chaining, because I checked it earlier, but it's stated in 6. to use optional chaining, normally I would use the guard at the end of the func
        // guard (items[id] as? Borrowable)?.borrow(returnDate: Date().addingTimeInterval(60 * 60 * 24 * 30)) == true else {
        //     throw LibraryError.pastReturnDate
        // }

        // return item

        guard borrowable.borrow(returnDate: Date().addingTimeInterval(60 * 60 * 24 * 30)) else {
            throw LibraryError.pastReturnDate
        }

        return item
    }
}
