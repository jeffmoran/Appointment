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

    var name: String? {
        !appointment.client.name.isEmpty ? appointment.client.name : "Client name unavailable"
    }

    var time: String {
        return DateFormatter.timeFormatter.string(from: appointment.time)
    }

    var address: String? {
        let address = "\(appointment.property.addressOne) \(appointment.property.zipCode)"
        return !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? address : nil
    }

    // MARK: - Initializers

    init(_ appointment: Appointment) {
        self.appointment = appointment
    }
}
