//
//  DateFormatter+Extensions.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/30/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy h:mm aa"

        return formatter
    }

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long

        return formatter
    }
}
