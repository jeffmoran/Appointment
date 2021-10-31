//
//  UIViewController+Extensions.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/22/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(
        title: String? = nil,
        message: String? = "",
        dismissActionTitle: String? = "Dismiss",
        defaultActionTitle: String? = nil,
        defaultActionAction: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if let defaultActionTitle = defaultActionTitle {
            alertController.addAction(UIAlertAction(title: defaultActionTitle, style: .default) { _ in
                defaultActionAction?()
            })

            alertController.addAction(UIAlertAction(title: dismissActionTitle, style: .cancel))
        } else {
            alertController.addAction(UIAlertAction(title: dismissActionTitle, style: .default))
        }

        present(alertController, animated: true)
    }
}
