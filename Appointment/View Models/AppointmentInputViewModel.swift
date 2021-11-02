//
//  AppointmentInputViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentInputViewModel {

    // MARK: - Private Properties

    private var appointment: Appointment?
    private let store: CoreDataStore<Appointment>

    // MARK: - Internal Properties

    lazy var sectionViewModels: [AppointmentInputSectionViewModel] = AppointmentDetailSection.allCases.map {
        AppointmentInputSectionViewModel(appointment, section: $0, delegate: self)
    }

    var title: String {
        return appointment?.client.name ?? "New Appointment"
    }

    var numberOfSections: Int {
        return sectionViewModels.count
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, store: CoreDataStore<Appointment>) {
        self.appointment = appointment
        self.store = store
    }

    // MARK: - Internal Methods

    func cellViewModel(for sectionIndex: Int, rowIndex: Int) -> AppointmentInputRowViewModel {
        let section = sectionViewModels[sectionIndex]
        return section.rowViewModels[rowIndex]
    }

    func save(_ completion: (Result<Void, Error>) -> Void) {
        do {
            try store.saveContext()

            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func rollback() {
        store.rollbackContext()
    }
}

// MARK: - AppointmentInputRowViewModelDelegate

extension AppointmentInputViewModel: AppointmentInputRowViewModelDelegate {
    private var appointmentToSave: Appointment {
        var appointmentToSave: Appointment

        if let appointment = appointment {
            appointmentToSave = appointment
        } else {
            appointmentToSave = store.newObject
            // swiftlint:disable force_unwrapping
            appointmentToSave.client = Client(context: appointmentToSave.managedObjectContext!)
            appointmentToSave.property = Property(context: appointmentToSave.managedObjectContext!)
            // swiftlint:enable force_unwrapping

            appointmentToSave.time = Date()
            appointmentToSave.notes = ""
            appointmentToSave.moveInDate = Date()

            appointmentToSave.client.name = ""
            appointmentToSave.client.emailAddress = ""
            appointmentToSave.client.phoneNumber = ""

            appointmentToSave.property.addressOne = ""
            appointmentToSave.property.zipCode = ""
            appointmentToSave.property.city = ""
            appointmentToSave.property.price = ""
            appointmentToSave.property.size = ""
            appointmentToSave.property.numberOfBedrooms = ""
            appointmentToSave.property.numberOfBathrooms = ""
        }

        return appointmentToSave
    }

    func didUpdate(with value: Any, row: AppointmentDetailSectionRow) {
        let appointmentToSave: Appointment = appointmentToSave

        let stringValue = (value as? String) ?? ""
        let dateValue = (value as? Date) ?? Date()

        row.update(appointment: appointmentToSave, stringValue: stringValue, dateValue: dateValue)

        appointment = appointmentToSave
    }
}
