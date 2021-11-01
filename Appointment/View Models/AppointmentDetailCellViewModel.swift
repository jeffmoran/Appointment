//
//  AppointmentDetailCellViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentDetailCellViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment?

    // MARK: - Internal Properties

    let detailType: AppointmentDetailType

    var headerValue: String {
        switch detailType {
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

    var value: Any {
        guard let appointment = appointment else {
            return ""
        }

        switch detailType {
        case .name:
            return appointment.clientName
        case .email:
            return appointment.clientEmail
        case .phoneNumber:
            return appointment.clientPhone
        case .time:
            return appointment.appointmentTime
        case .address:
            return appointment.address
        case .zipCode:
            return appointment.zipCode
        case .city:
            return appointment.city
        case .moveInDate:
            return appointment.moveInDate
        case .pets:
            return appointment.pets
        case .rent:
            let price = appointment.price

            if !price.isEmpty {
                return "$\(price) Per Month"
            } else {
                return ""
            }
        case .size:
            let size = appointment.size

            if !size.isEmpty {
                return "\(size) Sq. Ft."
            } else {
                return ""
            }
        case .bedrooms:
            return appointment.roomsCount
        case .bathrooms:
            return appointment.bathsCount
        case .notes:
            return appointment.notes
        }
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, type: AppointmentDetailType) {
        self.appointment = appointment
        detailType = type
    }
}
