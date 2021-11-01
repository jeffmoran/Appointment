//
//  Property.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import CoreData

class Property: NSManagedObject {
    @NSManaged var addressOne: String
    @NSManaged var addressTwo: String
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var zipCode: String
    @NSManaged var numberOfBedrooms: String
    @NSManaged var numberOfBathrooms: String
    @NSManaged var price: String
    @NSManaged var size: String
    @NSManaged var appointment: Appointment
}
