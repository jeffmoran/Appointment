//
//  ContactViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class ContactViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment

    // MARK: - Internal Properties

    var contactName: String {
        return appointment.client.name
    }

    var contactPhone: String {
        return appointment.client.phoneNumber
    }

    var contactEmail: String {
        return appointment.client.emailAddress
    }

    var successText: String {
        return "\(appointment.client.name) saved to Contacts!"
    }

    var failureText: String {
        return "Contact not Saved"
    }

    // MARK: - Initializers

    init(_ appointment: Appointment) {
        self.appointment = appointment
    }
}
