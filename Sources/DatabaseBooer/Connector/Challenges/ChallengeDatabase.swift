//
//  File.swift
//  
//
//  Created by Veit Progl on 16.02.23.
//

import Foundation
import CoreData

public protocol ChallengeDatabaseProtocol {
    func save_Book_IntervallPagesChallenge(data: BookIntervallPagesModell)
    func getAll_BookIntervallPageChallenges() -> [BookIntervallPagesModell]
}

class ChallengeDatabase: ChallengeDatabaseProtocol {
    var viewContext = PersistenceController.shared.container.viewContext

    func save_Book_IntervallPagesChallenge(data: BookIntervallPagesModell) {
        let bookResult = BookDatabase().getBook(id: data.bookID)
        
        let newChallenge = ChallengeIntervallPages(context: viewContext)
        newChallenge.id = data.challengeID
        newChallenge.pages = Int16(data.pages)
        newChallenge.intervall = data.intervall
        newChallenge.start = data.startDate
        
        switch bookResult {
        case let .success(book):
            newChallenge.book = book
        case let .failure(error):
            print("\(error)")
        }
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    func getAll_BookIntervallPageChallenges() -> [BookIntervallPagesModell] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ChallengeIntervallPages")

        var challenges: [BookIntervallPagesModell] = []
        do {
            let objects = try viewContext.fetch(fetch)
            for es in objects {
                if let object = es as? ChallengeIntervallPages {
                    challenges.append(BookIntervallPagesModell(from: object))
                }
            }
        } catch {
            print("error")
        }
        return challenges
    }
}
