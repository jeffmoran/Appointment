//
//  CalendarEmailViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class CalendarEmailViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment

    // MARK: - Internal Properties

    var eventTitle: String {
        return "\(DateFormatter.timeFormatter.string(from: appointment.time)) appointment with \(appointment.client.name)"
    }

    var eventLocation: String {
        return appointment.property.addressOne
    }

    var eventStartDate: Date {
        appointment.time
    }

    var eventEndDate: Date {
        Date(timeInterval: 3600, since: appointment.time)
    }

    var emailAddress: String {
        return appointment.client.emailAddress
    }

    var eventDetailsString: String {
        return """
    Client Name: \(appointment.client.name)
    Client Number: \(appointment.client.phoneNumber)
    Appointment Time \(appointment.time)
    Property Address: \(appointment.property.addressOne)
    City: \(appointment.property.city)
    Property Price: \(appointment.property.price)
    Move-In Date:\(appointment.moveInDate)
    Size: \(appointment.property.size) Sq. Ft.
    Number of Bedrooms:\(appointment.property.numberOfBedrooms)
    Number of Bathrooms:\(appointment.property.numberOfBathrooms)
    """
    }

    var successText: String {
        return "Appointment added to calendar!"
    }

    var failureText: String {
        return "Appointment not added to calendar."
    }

    // MARK: - Initializers

    init(_ appointment: Appointment) {
        self.appointment = appointment
    }
}
