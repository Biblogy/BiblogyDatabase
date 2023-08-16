//
//  File.swift
//  
//
//  Created by Veit Progl on 04.03.23.
//

import Foundation

protocol BookProgressProviderProtocol {
    func currentProgress(of book: BooksDB) -> Int
}

class BookProgressProvider: BookProgressProviderProtocol {
    func currentProgress(of book: BooksDB) -> Int {
        guard let progress = book.bookProgress else {
            return 1
        }
        
        if progress.count == 0 {
            return 1
        }
        
        let sorted = progress.sorted(by: { ($0 as! BookProgressDB).date! > ($1 as! BookProgressDB).date!})
        let first = sorted.first as! BookProgressDB
        return Int(first.pages)
    }
}
