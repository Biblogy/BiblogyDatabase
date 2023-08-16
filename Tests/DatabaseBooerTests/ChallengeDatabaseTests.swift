//
//  ChallengeTests.swift
//  
//
//  Created by Veit Progl on 21.02.23.
//

import Foundation
import XCTest
@testable import DatabaseBooer
import CoreData
//import BooerKit

final class ChallengeTests: XCTestCase {
    func test_save_Book_IntervallPagesChallenge() throws {
        let persistenceController = PersistenceController(inMemory: true)
        
        test("should save new challenge") {
            let sut = ChallengeDatabase()
            let mockViewContext = persistenceController.container.viewContext
            sut.viewContext = mockViewContext
            
            let uuid = UUID().uuidString
            let bookIntervallPage = BookIntervallPagesModell(bookID: uuid,
                                                             intervall: .month,
                                                             pages: 2,
                                                             challengeID: uuid,
                                                             bookTitle: "test title")
            
            sut.save_Book_IntervallPagesChallenge(data: bookIntervallPage)
            
            let result = sut.getAll_BookIntervallPageChallenges()
            XCTAssert(result.contains { $0.challengeID == uuid})
        }
    }
}
