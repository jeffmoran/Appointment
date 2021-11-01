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

    weak var delegate: AppointmentInputViewModelDelegate?

    lazy var cellViewModels: [AppointmentInputCellViewModel] = AppointmentDetailType.allCases.map {
        AppointmentInputCellViewModel(appointment, type: $0, delegate: self)
    }

    var title: String {
        return appointment?.client.name ?? "New Appointment"
    }

    var numberOfRows: Int {
        return cellViewModels.count
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, store: CoreDataStore<Appointment>) {
        self.appointment = appointment
        self.store = store
    }

    // MARK: - Internal Methods

    func save() {
        do {
            try store.saveContext()
            delegate?.didSuccesfullySave()
        } catch {
            delegate?.didFailToSave(error: error)
        }
    }
}

// MARK: - AppointmentInputCellViewModelDelegate

extension AppointmentInputViewModel: AppointmentInputCellViewModelDelegate {
    private var appointmentToSave: Appointment {
        var appointmentToSave: Appointment

        if let appointment = appointment {
            appointmentToSave = appointment
        } else {
            appointmentToSave = store.newObject
            appointmentToSave.time = Date()
            appointmentToSave.notes = ""
            appointmentToSave.moveInDate = Date()

            appointmentToSave.client = Client(context: appointmentToSave.managedObjectContext!)
            appointmentToSave.client.name = ""
            appointmentToSave.client.emailAddress = ""
            appointmentToSave.client.phoneNumber = ""

            appointmentToSave.property = Property(context: appointmentToSave.managedObjectContext!)
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

    func didUpdate(with value: Any, type: AppointmentDetailType) {
        let appointmentToSave: Appointment = appointmentToSave

        let stringValue = (value as? String) ?? ""
        let dateValue = (value as? Date) ?? Date()

        switch type {
        case .name:
            appointmentToSave.client.name = stringValue
        case .email:
            appointmentToSave.client.emailAddress = stringValue
        case .phoneNumber:
            appointmentToSave.client.phoneNumber = stringValue
        case .time:
            appointmentToSave.time = dateValue
        case .address:
            appointmentToSave.property.addressOne = stringValue
        case .zipCode:
            appointmentToSave.property.zipCode = stringValue
        case .city:
            appointmentToSave.property.city = stringValue
        case .moveInDate:
            appointmentToSave.moveInDate = dateValue
        case .rent:
            appointmentToSave.property.price = stringValue
        case .size:
            appointmentToSave.property.size = stringValue
        case .bedrooms:
            appointmentToSave.property.numberOfBedrooms = stringValue
        case .bathrooms:
            appointmentToSave.property.numberOfBathrooms = stringValue
        case .notes:
            appointmentToSave.notes = stringValue
        }

        appointment = appointmentToSave
    }
}
