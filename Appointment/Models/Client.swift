//
//  Client.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import CoreData

class Client: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var phoneNumber: String
    @NSManaged var emailAddress: String
    @NSManaged var appointment: Appointment
}
