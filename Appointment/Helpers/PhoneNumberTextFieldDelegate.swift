//
//  PhoneNumberTextFieldDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/29/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import UIKit

struct PhoneNumberTextFieldDelegate: AppointmentDetailTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let textCount = currentText.firstTenDigits.count
        let rangeLength = range.length

        // If the replacement string is empty (like when deleting a character), return true.
        if string.isEmpty {
            return true
        }

        // If typing/pasting in a string and no numbers are found, return false.
        if string.firstTenDigits.isEmpty {
            return false
        }

        if textCount == 10 && rangeLength == 0 {
            return false
        }

        let rawNumber = currentText.firstTenDigits

        let updatedText: String

        if textCount == 3 {
            if rangeLength > 0 {
                updatedText = "\(rawNumber.prefix(3))"
            } else {
                updatedText = "\(rawNumber)-"
            }
        } else if textCount == 6 {
            let component1 = rawNumber.prefix(3)
            let component2 = rawNumber.suffix(3)

            if rangeLength > 0 {
                updatedText = "\(component1)-\(component2)"
            } else {
                updatedText = "\(component1)-\(component2)-"
            }
        } else {
            updatedText = textField.text ?? ""
        }

        textField.text = updatedText

        return true
    }
}
