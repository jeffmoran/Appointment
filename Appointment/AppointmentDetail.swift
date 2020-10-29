//
//  AppointmentDetail.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/26/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

enum AppointmentDetail: Int, CaseIterable {
    case name
    case email
    case phoneNumber
    case time
    case address
    case zipCode
    case city
    case moveInDate
    case pets
    case rent
    case size
    case bedrooms
    case bathrooms
    case notes

    var headerValue: String {
        switch self {
        case .name:
            return "Client Name"
        case .email:
            return "Client Email"
        case .phoneNumber:
            return "Client Phone"
        case .time:
            return "Time"
        case .address:
            return "Property Address"
        case .zipCode:
            return "Zip / Postal Code"
        case .city:
            return "City"
        case .moveInDate:
            return "Move-In Date"
        case .pets:
            return "Pets"
        case .rent:
            return "Rent"
        case .size:
            return "Size"
        case .bedrooms:
            return "Bedrooms"
        case .bathrooms:
            return "Bathrooms"
        case .notes:
            return "Notes"
        }
    }

    var placeholderValue: String {
        switch self {
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

    func detailValue(for appointment: Appointment?) -> String? {
        guard let appointment = appointment else { return nil }

        switch self {
        case .name:
            return appointment.clientName
        case .email:
            return appointment.clientEmail
        case .phoneNumber:
            return appointment.clientPhone
        case .time:
            return appointment.appointmentDateString
        case .address:
            return appointment.address
        case .zipCode:
            return appointment.zipCode
        case .city:
            return appointment.city
        case .moveInDate:
            return appointment.moveInDateString
        case .pets:
            return appointment.pets
        case .rent:
            let price = appointment.price

            if !price.isEmpty {
                return "$\(price) Per Month"
            } else {
                return nil
            }
        case .size:
            let size = appointment.size

            if !size.isEmpty {
                return "\(size) Sq. Ft."
            } else {
                return nil
            }
        case .bedrooms:
            return appointment.roomsCount
        case .bathrooms:
            return appointment.bathsCount
        case .notes:
            return appointment.notes
        }
    }
}
