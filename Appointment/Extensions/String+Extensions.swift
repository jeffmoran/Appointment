//
//  String+Extensions.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/29/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

extension String {

    /// Returns only the decimal digits in the receiving string.
    var numbersOnly: String {
        return components(separatedBy: .decimalDigits.inverted).joined()
    }

    /// Returns the first 10 or less characters in the
    /// receiving string that are decimal digits.
    var firstTenDigits: String {
        return String(numbersOnly.prefix(10))
    }
}
