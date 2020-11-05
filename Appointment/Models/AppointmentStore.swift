//
//  AppointmentStore.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/26/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import CoreData

class AppointmentStore: NSObject {

    // MARK: - Static Properties

    static var shared = AppointmentStore()

    // MARK: - Private Properties

    private lazy var storeCoordinator: NSPersistentStoreCoordinator = {
        guard let model = NSManagedObjectModel.mergedModel(from: nil) else {
            fatalError("Model not created?")
        }

        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let url = URL(fileURLWithPath: path ?? "").appendingPathComponent("store.data")

        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]

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

    // MARK: - Internal Properties

    var count: Int {
        do {
            return try objectContext.count(for: Appointment.fetchRequest() as NSFetchRequest<NSFetchRequestResult>)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var allAppointments: [Appointment] {
        let fetchRequest = Appointment.fetchRequest()

        #warning("Make UserDefaults access type safe")
        if let value = UserDefaults.standard.string(forKey: "sortDescriptor") {
            let sortDescriptor = NSSortDescriptor(key: value, ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
        }

        do {
            // swiftlint:disable force_cast
            return try objectContext.fetch(fetchRequest) as! [Appointment]
            // swiftlint:enable force_cast
        } catch {
            print(error.localizedDescription)
            return [Appointment]()
        }
    }

    var emptyAppointment: Appointment {
        let appointment = NSEntityDescription.insertNewObject(forEntityName: "Appointment", into: objectContext)

        // swiftlint:disable force_cast
        return appointment as! Appointment
        // swiftlint:enable force_cast
    }

    // MARK: - Internal Methods

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
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Appointment.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try objectContext.execute(deleteRequest)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func delete(_ appointment: Appointment) {
        objectContext.delete(appointment)
    }
}
