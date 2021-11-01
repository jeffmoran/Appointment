//
//  AppointmentInputCellViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation
import UIKit

class AppointmentInputCellViewModel: AppointmentDetailCellViewModel {

    // MARK: - Types

    enum DisplayMode {
        case textField
        case datePicker
    }

    // MARK: - Private Properties

    private weak var delegate: AppointmentInputCellViewModelDelegate?

    // MARK: - Internal Properties

    var placeholderValue: String {
        switch detailType {
        case .name:
            return "John Appleseed"
        case .email:
            return "john@email.com"
        case .phoneNumber:
            return "555-555-5555"
        case .time:
            return ""
        case .address:
            return "826 Apple Street"
        case .zipCode:
            return "02128"
        case .city:
            return "Boston"
        case .moveInDate:
            return ""
        case .pets:
            return "Yes"
        case .rent:
            return "$2500"
        case .size:
            return "747"
        case .bedrooms:
            return "2"
        case .bathrooms:
            return "1"
        case .notes:
            return "Notes"
        }
    }

    var displayMode: DisplayMode {
        switch detailType {
        case .name:
            return .textField
        case .email:
            return .textField
        case .phoneNumber:
            return .textField
        case .time:
            return .datePicker
        case .address:
            return .textField
        case .zipCode:
            return .textField
        case .city:
            return .textField
        case .moveInDate:
            return .datePicker
        case .rent:
            return .textField
        case .size:
            return .textField
        case .bedrooms:
            return .textField
        case .bathrooms:
            return .textField
        case .notes:
            return .textField
        case .pets:
            return .textField
        }
    }

    var keyboardType: UIKeyboardType {
        switch detailType {
        case .bedrooms, .bathrooms, .rent, .size, .zipCode:
            return .numberPad
        case .phoneNumber:
            return .phonePad
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }

    var datePickerMode: UIDatePicker.Mode? {
        switch detailType {
        case .time:
            return .dateAndTime
        case .moveInDate:
            return .date
        default:
            return nil
        }
    }

    var textFieldDelegate: AppointmentDetailTextFieldDelegate? {
        switch detailType {
        case .phoneNumber:
            return PhoneNumberTextFieldDelegate()
        case .zipCode:
            return ZipCodeTextFieldDelegate()
        default:
            return nil
        }
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, type: AppointmentDetailType, delegate: AppointmentInputCellViewModelDelegate) {
        super.init(appointment, type: type)

        self.delegate = delegate
    }
}

// MARK: - AppointmentInputCellViewModelDelegate

extension AppointmentInputCellViewModel: AppointmentInputCellViewModelDelegate {
    func didUpdate(with value: Any, type: AppointmentDetailType) {
        delegate?.didUpdate(with: value, type: type)
    }
}
