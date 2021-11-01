//
//  Appointment.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/25/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import CoreData

class Appointment: NSManagedObject {
    @NSManaged var time: Date
    @NSManaged var moveInDate: Date
    @NSManaged var notes: String
    @NSManaged var client: Client
    @NSManaged var property: Property
}
