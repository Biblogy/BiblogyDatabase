//
//  BookModel.swift
//  
//
//  Created by Veit Progl on 30.05.22.
//

import Foundation

public struct Book: Decodable, Equatable, Identifiable {
    public var title: String
    public var pageCount: Float
    public var publisher: String? // why does this need to be optional? It shoudn't!
    public var author: [String]
    public var subtitle: String
    public let cover: Cover
    public var id = UUID().uuidString
    public var progress: Float?
    
    enum CodingKeys: String, CodingKey {
        case pageCount = "pages"
        case title = "title"
        case subtitle = "subtitle"
        case author = "authors"
        case publisher = "publisher"
        case cover = "cover"
        case progress = "progress"
    }
    
    public init(from book: BooksDB, progress: Int){
        self.id = book.id!
        self.title = book.title ?? ""
        self.pageCount = Float(book.pages)
        self.subtitle = book.subtitle ?? ""
        self.publisher = book.publisher ?? ""
        self.cover = Cover(smallThumbnail: book.coverSmall ?? "", thumbnail: book.coverThumbnail ?? "")
        self.author = []
        self.progress = Float(progress)

        guard let bookAuthors = book.bookAuthos else { return }
        for case let authorDB as AuthorDB in bookAuthors {
            self.author.append(authorDB.name ?? "")
        }
    }
    
    public init(title: String, pageCount: Int = 10, publisher: String = "", author: [String] = [""], subtitle: String = "", cover: Cover = Cover(smallThumbnail: "", thumbnail: ""), progress: Int = 1) {
        self.title = title
        self.pageCount = Float(pageCount)
        self.publisher = publisher
        self.author = author
        self.subtitle = subtitle
        self.cover = cover
        self.progress = Float(progress)
    }
    
    public init() {
        self.title = "Dummy Book"
        self.pageCount = 0
        self.author = [""]
        self.subtitle = ""
        self.cover = Cover(smallThumbnail: "", thumbnail: "")
        self.id = UUID().uuidString
        self.publisher = ""
        self.progress = 10
    }
}
