//  Persistence.swift
//  Shared
//
//  Created by Veit Progl on 30.05.22.
//

import CoreData

// Create a subclass of NSPersistentStore Coordinator
open class PersistentContainer: NSPersistentContainer {
}

public struct PersistenceController {
    public static let shared = PersistenceController()

    public static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = BooksDB(context: viewContext)
            newItem.title = "demo"
            newItem.descriptionText = "123"
            newItem.id = UUID().uuidString
            newItem.pages = 16
            newItem.subtitle = "test"
            newItem.coverThumbnail = ""
            newItem.coverSmall = ""

            let newAuthor = AuthorDB(context: viewContext)
            newAuthor.id = UUID().uuidString
            newAuthor.name = "test"

            newItem.addToBookAuthos(newAuthor)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    public let container: NSPersistentContainer

    public init(inMemory: Bool = false) {
        let modelURL = Bundle.module.url(forResource:"BooerData", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!
        container = NSPersistentContainer(name: "BooerData", managedObjectModel: model)

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
