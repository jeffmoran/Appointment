//
//  AppointmentListViewControllerDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/25/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import Foundation

@objc protocol AppointmentListViewControllerDelegate: AnyObject {
    func refreshAppointmentList()
}
