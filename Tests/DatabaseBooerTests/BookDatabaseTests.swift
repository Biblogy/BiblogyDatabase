//
//  File.swift
//  
//
//  Created by Veit Progl on 22.02.23.
//

import Foundation
import XCTest
@testable import DatabaseBooer
//import BooerKit

final class BookDatabaseTests: XCTestCase {
    var sut: BookDatabase!
    let testTitle = "test Book"

    override func setUp() async throws {
        try await super.setUp()
        
        sut = BookDatabase()
        sut.viewContext = PersistenceController(inMemory: true).container.viewContext
    }
    
    
    func test_saveBook() throws {
        test("should save new book") {
            let mockBook = Book(title: testTitle)
            
            sut.saveBook(book: mockBook)
            
            let books = sut.getAllBooks()
            XCTAssert(books.contains { $0.title == testTitle} )
        }
    }
    
    func test_deleteBook() throws {
        test("should remvoe book") {
            let mockBook = Book(title: testTitle)
            
            sut.saveBook(book: mockBook)
            
            var books = sut.getAllBooks()
            XCTAssert(books.contains { $0.title == testTitle} )

            books.forEach { book in
                sut.deleteBook(book: book)
            }
            
            books = sut.getAllBooks()
            XCTAssertFalse(books.contains { $0.title == testTitle} )
            XCTAssert(books.count == 0)
        }
    }
    
    func test_updateBook() throws {
        test("should change book title") {
            var mockBook = Book(title: testTitle)
            
            sut.saveBook(book: mockBook)
            
            var books = sut.getAllBooks()
            XCTAssert(books.contains { $0.title == testTitle} )
            
            let newTitle = "changed Title"
            
            mockBook.title = newTitle
            
            sut.updateBook(book: mockBook)
            
            books = sut.getAllBooks()
            XCTAssertFalse(books.contains { $0.title == testTitle} )
            XCTAssert(books.contains { $0.title == newTitle} )

            
        }
    }
}

extension XCTestCase {
    func test<T>(_ description: String, block: () throws -> T) rethrows -> T {
        try XCTContext.runActivity(named: description, block: { _ in try block() })
    }
}
