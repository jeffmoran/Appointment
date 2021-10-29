//
//  Appointment.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/25/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import CoreData

class Appointment: NSManagedObject {
    #warning("Move these date formatters to somewhere more reasonable")

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm aa"

        return formatter
    }

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long

        return formatter
    }

    @NSManaged var address: String
    @NSManaged var appointmentTime: Date
    @NSManaged var bathsCount: String
    @NSManaged var city: String
    @NSManaged var clientEmail: String
    @NSManaged var clientName: String
    @NSManaged var clientPhone: String
    @NSManaged var moveInDate: Date
    @NSManaged var pets: String
    @NSManaged var price: String
    @NSManaged var roomsCount: String
    @NSManaged var size: String
    @NSManaged var zipCode: String
    @NSManaged var notes: String

    var appointmentDateString: String {
        return Appointment.timeFormatter.string(from: appointmentTime)
    }

    var moveInDateString: String {
        return Appointment.dateFormatter.string(from: moveInDate)
    }

    #warning("Implement")
    var calendarNotesString: String = ""
    var emailBodyString: String = ""
}
