//
//  AppointmentDetail.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/26/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import Foundation

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

    func detailValue(for appointment: Appointment) -> String? {
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
            return "$\(appointment.price) Per Month"
        case .size:
            return "\(appointment.size) Sq. Ft."
        case .bedrooms:
            return appointment.roomsCount
        case .bathrooms:
            return appointment.bathsCount
        case .notes:
            return appointment.notes
        }
    }
}
