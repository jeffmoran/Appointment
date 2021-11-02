//
//  AppointmentDetailRowViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentDetailRowViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment?

    // MARK: - Internal Properties

    let row: AppointmentDetailSectionRow

    var headerValue: String {
        return row.headerValue
    }

    var value: AppointmentDetailValueType {
        guard let appointment = appointment else {
            return .string("")
        }

        return row.value(with: appointment)
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, row: AppointmentDetailSectionRow) {
        self.appointment = appointment
        self.row = row
    }
}
