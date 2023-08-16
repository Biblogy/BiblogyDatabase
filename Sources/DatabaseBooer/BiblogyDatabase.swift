import CoreData
public struct BiblogyDatabase {
    var viewContext = PersistenceController.shared.container.viewContext
    public static let shared = BiblogyDatabase()
    
    public init() {
        getCoreDataLocation()
    }
    
    public init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        getCoreDataLocation()
    }
    
    public let challenge: ChallengeDatabaseProtocol = ChallengeDatabase() 
    public let books: BookDatabaseProtrocol = BookDatabase()

    func getCoreDataLocation(){
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(urls[urls.count-1] as URL)
    }
    
}
