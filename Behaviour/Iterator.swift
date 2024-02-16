struct Book {
    let title: String
    let author: String
}

class BookIterator: IteratorProtocol {
    private var current = 0
    private var books: [Book]
    
    init(_ books: [Book]) {
        self.books = books
    }
    
    func next() -> Book? {
        guard current < books.count else { return nil }
        let book = books[current]
        current += 1
        return book
    }
}

class Library: Sequence {
    private var books: [Book] = []
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func makeIterator() -> BookIterator {
        return BookIterator(books)
    }
}

let library = Library()
library.addBook(Book(title: "1984", author: "George Orwell"))
library.addBook(Book(title: "Brave New World", author: "Aldous Huxley"))
library.addBook(Book(title: "Fahrenheit 451", author: "Ray Bradbury"))

for book in library {
    print("Book: \(book.title) by \(book.author)")
}
