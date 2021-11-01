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
            return appointment.client.name
        case .email:
            return appointment.client.emailAddress
        case .phoneNumber:
            return appointment.client.phoneNumber
        case .time:
            return appointment.time
        case .address:
            return appointment.property.addressOne
        case .zipCode:
            return appointment.property.zipCode
        case .city:
            return appointment.property.city
        case .moveInDate:
            return appointment.moveInDate
        case .rent:
            let price = appointment.property.price

            if !price.isEmpty {
                return "$\(price) Per Month"
            } else {
                return ""
            }
        case .size:
            let size = appointment.property.size

            if !size.isEmpty {
                return "\(size) Sq. Ft."
            } else {
                return ""
            }
        case .bedrooms:
            return appointment.property.numberOfBedrooms
        case .bathrooms:
            return appointment.property.numberOfBathrooms
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
