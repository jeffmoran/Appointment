//
//  ZipCodeTextFieldDelegate.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/29/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import UIKit

struct ZipCodeTextFieldDelegate: AppointmentDetailTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // If the replacement string is empty (like when deleting a character), return true.
        if string.isEmpty {
            return true
        }

        // If typing/pasting in a string and no numbers are found, return false.
        if string.numbersOnly.isEmpty {
            return false
        }

        let currentText = textField.text ?? ""

        if let stringRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string.numbersOnly)

            if updatedText.count <= 5 {
                // If we land in here, the processed string should only contain
                // numbers and be less than or equal to 5 characters.
                textField.text = updatedText
            }
        }

        // Always return false as we rely on the textField text being set manually above.
        return false
    }
}
