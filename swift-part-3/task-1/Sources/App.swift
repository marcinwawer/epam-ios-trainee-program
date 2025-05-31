import Foundation

@main
struct App {
    static func main() {
        runApp()
    }
}

fileprivate func runApp() {
    let library = Library()

    let book = Book(title: "Test Book", author: "John Doe")
    let sameBook = book 
    let fakeID = UUID().uuidString 

    do {
        try library.addBook(book)
    } catch {
        print("Error adding book: \(error)")
    }

    do {
        try library.addBook(sameBook)
    } catch {
        print("Expected error (already added): \(error)")
    }

    do {
        let borrowed = try library.borrowItem(by: book.id)
        print("Borrowed item: \(borrowed.title)")
    } catch {
        print("Error borrowing book: \(error)")
    }

    do {
        _ = try library.borrowItem(by: book.id)
    } catch {
        print("Expected error (already borrowed): \(error)")
    }

    do {
        _ = try library.borrowItem(by: fakeID)
    } catch {
        print("Expected error (item not found): \(error)")
    }
}