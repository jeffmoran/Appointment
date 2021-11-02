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
    case moveInDate
    case notes

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

    func value(with appointment: Appointment) -> AppointmentDetailValueType {
        switch self {
        case .time:
            return .date(appointment.time, .timeFormatter)
        case .notes:
            return .string(appointment.notes)
        case .moveInDate:
            return .date(appointment.moveInDate, .dateFormatter)
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
