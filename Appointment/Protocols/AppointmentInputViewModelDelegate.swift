//
//  AppointmentInputViewModelDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

protocol AppointmentInputViewModelDelegate: AnyObject {
    func didSuccesfullySave()
    func didFailToSave(error: Error)
}
