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
        return appointment?.clientName ?? "New Appointment"
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
            appointmentToSave.clientName = ""
            appointmentToSave.clientEmail = ""
            appointmentToSave.clientPhone = ""
            appointmentToSave.appointmentTime = Date()
            appointmentToSave.address = ""
            appointmentToSave.zipCode = ""
            appointmentToSave.city = ""
            appointmentToSave.moveInDate = Date()
            appointmentToSave.pets = ""
            appointmentToSave.price = ""
            appointmentToSave.size = ""
            appointmentToSave.roomsCount = ""
            appointmentToSave.bathsCount = ""
            appointmentToSave.notes = ""
        }

        return appointmentToSave
    }

    func didUpdate(with value: Any, type: AppointmentDetailType) {
        let appointmentToSave: Appointment = appointmentToSave

        let stringValue = (value as? String) ?? ""
        let dateValue = (value as? Date) ?? Date()

        switch type {
        case .name:
            appointmentToSave.clientName = stringValue
        case .email:
            appointmentToSave.clientEmail = stringValue
        case .phoneNumber:
            appointmentToSave.clientPhone = stringValue
        case .time:
            appointmentToSave.appointmentTime = dateValue
        case .address:
            appointmentToSave.address = stringValue
        case .zipCode:
            appointmentToSave.zipCode = stringValue
        case .city:
            appointmentToSave.city = stringValue
        case .moveInDate:
            appointmentToSave.moveInDate = dateValue
        case .pets:
            appointmentToSave.pets = stringValue
        case .rent:
            appointmentToSave.price = stringValue
        case .size:
            appointmentToSave.size = stringValue
        case .bedrooms:
            appointmentToSave.roomsCount = stringValue
        case .bathrooms:
            appointmentToSave.bathsCount = stringValue
        case .notes:
            appointmentToSave.notes = stringValue
        }

        appointment = appointmentToSave
    }
}
