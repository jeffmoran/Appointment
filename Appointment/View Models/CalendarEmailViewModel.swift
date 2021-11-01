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
        return "\(DateFormatter.timeFormatter.string(from: appointment.appointmentTime)) appointment with \(appointment.clientName)"
    }

    var eventLocation: String {
        return appointment.address
    }

    var eventStartDate: Date {
        appointment.appointmentTime
    }

    var eventEndDate: Date {
        Date(timeInterval: 3600, since: appointment.appointmentTime)
    }

    var emailAddress: String {
        return appointment.clientEmail
    }

    var eventDetailsString: String {
        return """
    Client Name: \(appointment.clientName)
    Client Number: \(appointment.clientPhone)
    Appointment Time \(appointment.appointmentTime)
    Property Address: \(appointment.address)
    City: \(appointment.city)
    Property Price: \(appointment.price)
    Move-In Date:\(appointment.moveInDate)
    Pets Allowed: \(appointment.pets)
    Size: \(appointment.size) Sq. Ft.
    Number of Bedrooms:\(appointment.roomsCount)
    Number of Bathrooms:\(appointment.bathsCount)
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
