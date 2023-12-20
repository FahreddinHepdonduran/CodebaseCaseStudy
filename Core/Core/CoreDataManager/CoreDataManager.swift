import Foundation
import CoreData
import AppResources

public enum FavoritesEntityType {
    case favoriteSeller
    case realEstate
}

public final class CoreDataManager {
    
    public static let shared = CoreDataManager()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let modelName = "Favorites"
        
        let bundle = Bundle.AppBundle.Core.initBundle
        
        guard let modelURL = bundle?.url(forResource: modelName, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            print("Failed to load the managed object model")
            return .init(name: modelName)
        }
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Failed to load Core Data stack: \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    public func saveItem(_ id: Int, forType: FavoritesEntityType) {
        switch forType {
        case .favoriteSeller:
            let newItem = FavoriteSeller(context: context)
            newItem.id = Int64(id)
        case .realEstate:
            let newItem = RealEstate(context: context)
            newItem.id = Int64(id)
        }
        
        saveContext()
    }
    
    public func containsItem(with id: Int, forType: FavoritesEntityType) -> Bool {
        switch forType {
        case .favoriteSeller:
            let items: [FavoriteSeller] = fetchItems()
            return items.contains(where: { Int($0.id) == id })
        case .realEstate:
            let items: [RealEstate] = fetchItems()
            return items.contains(where: { Int($0.id) == id })
        }
    }
    
    public func deleteItemByID(id: Int, forType: FavoritesEntityType) {
        switch forType {
        case .favoriteSeller:
            let items: [FavoriteSeller] = fetchItems()

            guard let item = items.first(where: { Int($0.id) == id }) else {
                return
            }

            context.delete(item)
        case .realEstate:
            let items: [RealEstate] = fetchItems()

            guard let item = items.first(where: { Int($0.id) == id }) else {
                return
            }

            context.delete(item)
        }

        saveContext()
    }
}

// MARK: - Private Extension
private extension CoreDataManager {
    
    func saveContext() {
        try? persistentContainer.viewContext.save()
    }
    
    func fetchItems<T: NSManagedObject>() -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        guard let items = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        
        return items
    }
    
}
