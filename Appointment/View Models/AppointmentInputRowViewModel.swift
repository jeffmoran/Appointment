//
//  AddEditAppointmentRowViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation
import UIKit

class AppointmentInputRowViewModel: AppointmentDetailRowViewModel {

    // MARK: - Types

    enum DisplayMode {
        case textField(keyboardType: UIKeyboardType)
        case datePicker(datePickerMode: UIDatePicker.Mode)
    }

    // MARK: - Private Properties

    private weak var delegate: AppointmentInputRowViewModelDelegate?

    // MARK: - Internal Properties

    var placeholderValue: String? {
        return row.placeholder
    }

    var displayMode: DisplayMode {
        return row.displayMode
    }

    var textFieldDelegate: AppointmentDetailTextFieldDelegate? {
        return row.textFieldDelegate
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, row: AppointmentDetailSectionRow, delegate: AppointmentInputRowViewModelDelegate) {
        super.init(appointment, row: row)

        self.delegate = delegate
    }
}

// MARK: - AppointmentInputRowViewModelDelegate

extension AppointmentInputRowViewModel: AppointmentInputRowViewModelDelegate {
    func didUpdate(with value: Any, row: AppointmentDetailSectionRow) {
        delegate?.didUpdate(with: value, row: row)
    }
}
