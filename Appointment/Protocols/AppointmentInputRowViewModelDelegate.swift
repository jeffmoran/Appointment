//
//  AppointmentInputRowViewModelDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

protocol AppointmentInputRowViewModelDelegate: AnyObject {
    func didUpdate(with value: Any, row: AppointmentDetailSectionRow)
}
