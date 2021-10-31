//
//  Appointment.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/25/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import CoreData

class Appointment: NSManagedObject {
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
        return DateFormatter.timeFormatter.string(from: appointmentTime)
    }

    var moveInDateString: String {
        return DateFormatter.dateFormatter.string(from: moveInDate)
    }

    var detailsString: String {
        return """
Client Name: \(clientName)
Client Number: \(clientPhone)
Appointment Time \(appointmentDateString)
Property Address: \(address)
City: \(city)
Property Price: \(price)
Move-In Date:\(moveInDateString)
Pets Allowed: \(pets)
Size: \(size) Sq. Ft.
Number of Bedrooms:\(roomsCount)
Number of Bathrooms:\(bathsCount)
"""
    }
}
