//
//  CoreDataStore.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/26/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import CoreData

class CoreDataStore<T: NSManagedObject> {

    // MARK: - Private Properties

    private var entityName: String {
        return String(describing: T.self)
    }

    private var fetchRequest: NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: entityName)
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: entityName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        return container
    }()

    private lazy var objectContext: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    // MARK: - Internal Properties

    var newObject: T {
        // swiftlint:disable force_cast
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: objectContext) as! T
        // swiftlint:enable force_cast
    }

    // MARK: - Internal Methods

    func fetchAllObjects(with sortDescriptors: [NSSortDescriptor]) -> [T] {
        do {
            let request = fetchRequest
            request.sortDescriptors = sortDescriptors
            return try objectContext.fetch(request)
        } catch {
            print(error.localizedDescription)
            return [T]()
        }
    }

    func saveContext() throws {
        if objectContext.hasChanges {
            try objectContext.save()
        }
    }

    func rollbackContext() {
        objectContext.rollback()
        objectContext.refreshAllObjects()
    }

    func deleteAll() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: T.fetchRequest())

        do {
            try objectContext.execute(deleteRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func delete(_ object: T) throws {
        objectContext.delete(object)
        try saveContext()
    }
}
