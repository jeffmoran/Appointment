//
//  InputTextField.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/16/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class InputTextField: UITextField {

    // MARK: - Initializers

    @objc init(withPlaceholder placeholder: String) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.7
        layer.cornerRadius = 5.0
        layer.backgroundColor = UIColor.white.cgColor
        font = .systemFont(ofSize: 16.0)
        clearButtonMode = .always
        autocapitalizationType = .words
        autocorrectionType = .yes
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method Overrides

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 5, y: bounds.origin.y, width: bounds.size.width - 20, height: bounds.size.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
