//
//  AppointmentListViewControllerDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/25/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

protocol AppointmentListViewControllerDelegate: AnyObject {
    func didDeleteAllAppointments()
    func refreshAppointmentList()
}
