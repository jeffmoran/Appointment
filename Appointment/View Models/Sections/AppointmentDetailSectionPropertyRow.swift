//
//  AppointmentDetailSectionPropertyRow.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

enum AppointmentDetailSectionPropertyRow: Int, CaseIterable, AppointmentDetailSectionRow {
    case addressOne
    case addressTwo
    case city
    case state
    case zipCode
    case rent
    case size
    case bedrooms
    case bathrooms

    var headerValue: String {
        switch self {
        case .addressOne:
            return "Address 1"
        case .addressTwo:
            return "Address 2"
        case .city:
            return "City"
        case .state:
            return "State"
        case .zipCode:
            return "Zip / Postal Code"
        case .rent:
            return "Rent"
        case .size:
            return "Size"
        case .bedrooms:
            return "Bedrooms"
        case .bathrooms:
            return "Bathrooms"
        }
    }

    var placeholder: String? {
        switch self {
        case .addressOne:
            return "Apple Street"
        case .addressTwo:
            return "APT. 826"
        case .city:
            return "Boston"
        case .state:
            return "Massachusetts"
        case .zipCode:
            return "02128"
        case .rent:
            return "$2500"
        case .size:
            return "747"
        case .bedrooms:
            return "2"
        case .bathrooms:
            return "1"
        }
    }

    var displayMode: AppointmentInputRowViewModel.DisplayMode {
        switch self {
        case .addressOne, .addressTwo, .city, .state:
            return .textField(keyboardType: .default)
        case .zipCode, .rent, .size, .bedrooms, .bathrooms:
            return .textField(keyboardType: .numberPad)
        }
    }

    var textFieldDelegate: AppointmentDetailTextFieldDelegate? {
        switch self {
        case .zipCode:
            return ZipCodeTextFieldDelegate()
        default:
            return nil
        }
    }

    func value(with appointment: Appointment) -> AppointmentDetailValueType {
        switch self {
        case .addressOne:
            return .string(appointment.property.addressOne)
        case .addressTwo:
            return .string(appointment.property.addressTwo)
        case .city:
            return .string(appointment.property.city)
        case .state:
            return .string(appointment.property.state)
        case .zipCode:
            return .string(appointment.property.zipCode)
        case .rent:
            var price = appointment.property.price

            if price.isEmpty {
                price = "0"
            }

            return .string("$\(price) Per Month")
        case .size:
            var size = appointment.property.size

            if size.isEmpty {
                size = "0"
            }

            return .string("\(size) Sq. Ft.")
        case .bedrooms:
            return .string(appointment.property.numberOfBedrooms)
        case .bathrooms:
            return .string(appointment.property.numberOfBathrooms)
        }
    }

    func update(appointment: Appointment, stringValue: String, dateValue: Date) {
        switch self {
        case .addressOne:
            appointment.property.addressOne = stringValue
        case .addressTwo:
            appointment.property.addressTwo = stringValue
        case .city:
            appointment.property.city = stringValue
        case .state:
            appointment.property.state = stringValue
        case .zipCode:
            appointment.property.zipCode = stringValue
        case .rent:
            appointment.property.price = stringValue
        case .size:
            appointment.property.size = stringValue
        case .bedrooms:
            appointment.property.numberOfBedrooms = stringValue
        case .bathrooms:
            appointment.property.numberOfBathrooms = stringValue
        }
    }
}
