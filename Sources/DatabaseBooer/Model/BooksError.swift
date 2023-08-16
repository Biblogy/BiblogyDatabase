//
//  File.swift
//  
//
//  Created by Veit Progl on 25.02.23.
//

import Foundation

public enum BooksError: Error {
    case BookIdNotFound
    case TitleNotFound
    case DeleteFailed
}
