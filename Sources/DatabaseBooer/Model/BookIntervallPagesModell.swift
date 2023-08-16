//
//  BookIntervallPagesModell.swift
//  
//
//  Created by Veit Progl on 21.02.23.
//

import Foundation

public struct BookIntervallPagesModell {
    public var bookID: String
    public var intervall: Intervall
    public var pages: Int
    public var challengeID: String
    public var bookTitle: String
    public var startDate: Date?
    public var endDate: Date?
    public var bookProgress: [BookProgress]?
    public var maxBookPages: Int?
    
    public init(bookID:String, intervall: Intervall, pages: Int, challengeID: String = UUID().uuidString, bookTitle: String) {
        self.bookID = bookID
        self.intervall = intervall
        self.pages = pages
        self.challengeID = challengeID
        self.bookTitle = bookTitle
    }
    
    //TODO: better error handling
    public init(from challenge: ChallengeIntervallPages) {
        self.bookID = challenge.book?.id ?? ""
        self.intervall = challenge.intervall
        self.pages = Int(challenge.pages)
        self.challengeID = challenge.id!
        self.bookTitle = challenge.book?.title ?? "error"
        self.startDate = challenge.start
        self.maxBookPages = Int(challenge.book?.pages ?? 10)
        
        self.bookProgress = getProgressFromBook(book: challenge.book)
    }
    
    func getProgressFromBook(book: BooksDB?) -> [BookProgress] {
        guard let book = book else { return [] }
        let bookModel = Book(from: book, progress: 0)
        guard let bookProgressData = book.bookProgress?.allObjects as? [BookProgressDB] else { return [] }
        return bookProgressData.map { progress in
            BookProgress(book: bookModel, pages: Int(progress.pages), date: progress.date ?? Date())
        }
    }
}
