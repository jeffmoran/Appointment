//
//  AppointmentListCellViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentListCellViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment

    // MARK: - Internal Properties

    var name: String {
        !appointment.clientName.isEmpty ? appointment.clientName : "Client name unavailable"
    }

    var time: String {
        return DateFormatter.timeFormatter.string(from: appointment.appointmentTime)
    }

    var address: String {
        let address = "\(appointment.address) \(appointment.zipCode)"
        return !address.isEmpty ? address : "Property address unavailable"
    }

    // MARK: - Initializers

    init(_ appointment: Appointment) {
        self.appointment = appointment
    }
}
