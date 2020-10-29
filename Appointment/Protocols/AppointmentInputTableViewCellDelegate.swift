//
//  AppointmentInputTableViewCellDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/29/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

protocol AppointmentInputTableViewCellDelegate: AnyObject {
    func didUpdateCell(with value: Any, appointmentDetail: AppointmentDetail)
}
