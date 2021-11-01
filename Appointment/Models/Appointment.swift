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
}
