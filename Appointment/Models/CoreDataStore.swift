//
//  CoreDataStore.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/26/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import CoreData

class CoreData<T: NSManagedObject> {

    // MARK: - Private Properties

    private lazy var storeCoordinator: NSPersistentStoreCoordinator = {
        guard let model = NSManagedObjectModel.mergedModel(from: nil) else {
            fatalError("Model not created?")
        }

        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]

            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("store.data")

            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            fatalError(error.localizedDescription)
        }

        return storeCoordinator
    }()

    private lazy var objectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = storeCoordinator

        return context
    }()

    var allObjects: [T] {
        let fetchRequest = T.fetchRequest()

        do {
            // swiftlint:disable force_cast
            return try objectContext.fetch(fetchRequest) as! [T]
            // swiftlint:enable force_cast
        } catch {
            print(error.localizedDescription)
            return [T]()
        }
    }

    var count: Int {
        do {
            return try objectContext.count(for: T.fetchRequest() as NSFetchRequest<NSFetchRequestResult>)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var newObject: T {
        // swiftlint:disable force_cast
        return NSEntityDescription.insertNewObject(forEntityName: T.description(), into: objectContext) as! T
        // swiftlint:enable force_cast
    }

    func save() {
        do {
            if objectContext.hasChanges {
                try objectContext.save()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = T.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try objectContext.execute(deleteRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func delete(_ object: T) {
        objectContext.delete(object)
    }
}
