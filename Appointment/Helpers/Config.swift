//
//  Config.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/29/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

// swiftlint:disable let_var_whitespace

enum Config {
    @UserDefault(key: "appointmentSortingType", defaultValue: .timeAscending)
    static var appointmentSortingType: AppointmentSortingType
}

// swiftlint:enable let_var_whitespace
