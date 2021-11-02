//
//  AppointmentDetailSectionRow.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

protocol AppointmentDetailSectionRow {
    var headerValue: String { get }
    var placeholder: String? { get }
    var displayMode: AppointmentInputRowViewModel.DisplayMode { get }
    var textFieldDelegate: AppointmentDetailTextFieldDelegate? { get }

    func value(for appointment: Appointment) -> Any
    func update(appointment: Appointment, stringValue: String, dateValue: Date)
}

extension AppointmentDetailSectionRow {
    var textFieldDelegate: AppointmentDetailTextFieldDelegate? {
        return nil
    }
}
