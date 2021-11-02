//
//  AppointmentDetailSectionContactRow.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

enum AppointmentDetailSectionContactRow: Int, CaseIterable, AppointmentDetailSectionRow {
    case name
    case email
    case phoneNumber

    var headerValue: String {
        switch self {
        case .name:
            return "Name"
        case .email:
            return "Email"
        case .phoneNumber:
            return "Phone"
        }
    }

    var placeholder: String? {
        switch self {
        case .name:
            return "John Appleseed"
        case .email:
            return "john@email.com"
        case .phoneNumber:
            return "555-555-5555"
        }
    }

    var displayMode: AppointmentInputRowViewModel.DisplayMode {
        switch self {
        case .name:
            return .textField(keyboardType: .default)
        case .email:
            return .textField(keyboardType: .emailAddress)
        case .phoneNumber:
            return .textField(keyboardType: .phonePad)
        }
    }

    var textFieldDelegate: AppointmentDetailTextFieldDelegate? {
        switch self {
        case .phoneNumber:
            return PhoneNumberTextFieldDelegate()
        default:
            return nil
        }
    }

    func value(with appointment: Appointment) -> AppointmentDetailValueType {
        switch self {
        case .name:
            return .string(appointment.client.name)
        case .email:
            return .string(appointment.client.emailAddress)
        case .phoneNumber:
            return .string(appointment.client.phoneNumber)
        }
    }

    func update(appointment: Appointment, stringValue: String, dateValue: Date) {
        switch self {
        case .name:
            appointment.client.name = stringValue
        case .email:
            appointment.client.emailAddress = stringValue
        case .phoneNumber:
            appointment.client.phoneNumber = stringValue
        }
    }
}
