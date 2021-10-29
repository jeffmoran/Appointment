//
//  AppointmentDetailTextFieldDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/4/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

protocol AppointmentDetailTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}
