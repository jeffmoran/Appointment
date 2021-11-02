//
//  AppointmentDetailSectionPropertyRow.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

enum AppointmentDetailSectionPropertyRow: Int, CaseIterable, AppointmentDetailSectionRow {
    case address
    case zipCode
    case city
    case rent
    case size
    case bedrooms
    case bathrooms

    var headerValue: String {
        switch self {
        case .address:
            return "Property Address"
        case .zipCode:
            return "Zip / Postal Code"
        case .city:
            return "City"
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
        case .address:
            return "826 Apple Street"
        case .zipCode:
            return "02128"
        case .city:
            return "Boston"
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
        case .address, .city:
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

    func value(for appointment: Appointment) -> Any {
        switch self {
        case .address:
            return appointment.property.addressOne
        case .zipCode:
            return appointment.property.zipCode
        case .city:
            return appointment.property.city
        case .rent:
            var price = appointment.property.price

            if price.isEmpty {
                price = "0"
            }

            return "$\(price) Per Month"
        case .size:
            var size = appointment.property.size

            if size.isEmpty {
                size = "0"
            }

            return "\(size) Sq. Ft."
        case .bedrooms:
            return appointment.property.numberOfBedrooms
        case .bathrooms:
            return appointment.property.numberOfBathrooms
        }
    }

    func update(appointment: Appointment, stringValue: String, dateValue: Date) {
        switch self {
        case .address:
            appointment.property.addressOne = stringValue
        case .zipCode:
            appointment.property.zipCode = stringValue
        case .city:
            appointment.property.city = stringValue
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
