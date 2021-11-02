//
//  AppointmentDetailSectionAppointmentRow.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

enum AppointmentDetailSectionAppointmentRow: Int, CaseIterable, AppointmentDetailSectionRow {
    case time
    case notes
    case moveInDate

    var headerValue: String {
        switch self {
        case .time:
            return "Time"
        case .moveInDate:
            return "Move-In Date"
        case .notes:
            return "Notes"
        }
    }

    var placeholder: String? {
        switch self {
        case .time, .moveInDate:
            return nil
        case .notes:
            return "Notes"
        }
    }

    var displayMode: AppointmentInputRowViewModel.DisplayMode {
        switch self {
        case .time:
            return .datePicker(datePickerMode: .dateAndTime)
        case .moveInDate:
            return .datePicker(datePickerMode: .date)
        case .notes:
            return .textField(keyboardType: .default)
        }
    }

    func value(for appointment: Appointment) -> Any {
        switch self {
        case .time:
            return appointment.time
        case .notes:
            return appointment.notes
        case .moveInDate:
            return appointment.moveInDate
        }
    }

    func update(appointment: Appointment, stringValue: String, dateValue: Date) {
        switch self {
        case .time:
            appointment.time = dateValue
        case .notes:
            appointment.notes = stringValue
        case .moveInDate:
            appointment.moveInDate = dateValue
        }
    }
}
