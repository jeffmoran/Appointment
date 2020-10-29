//
//  AppointmentInputTableViewCell.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/27/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class AppointmentInputTableViewCell: UITableViewCell {

    // MARK: - Static Constants

    static let reuseIdentifier = "appointmentInputTableViewCellIdentifier"

    // MARK: - Private Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.alignment = .center

        return stackView
    }()

    private lazy var appointmentHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14.0)

        return label
    }()

    private lazy var appointmentTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.autocapitalizationType = .words

        return textField
    }()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(didSelectTime(_:)), for: .valueChanged)

        return datePicker
    }()

    private var appointmentDetail: AppointmentDetail?

    // MARK: - Internal Properties

    weak var delegate: AppointmentInputTableViewCellDelegate?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        setUpConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func addSubviews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(appointmentHeaderLabel)
        stackView.addArrangedSubview(appointmentTextField)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            appointmentHeaderLabel.widthAnchor.constraint(equalToConstant: 90),

            appointmentTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44.0),

            stackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)
        ])
    }

    @objc private func didSelectTime(_ datePicker: UIDatePicker) {
        guard let appointmentDetail = appointmentDetail else {
            fatalError("appointmentDetail should not be nil!")
        }

        delegate?.didUpdateCell(with: datePicker.date, appointmentDetail: appointmentDetail)
    }

    // MARK: - Internal Methods

    func style(with appointmentDetail: AppointmentDetail, value: Any?) {
        self.appointmentDetail = appointmentDetail

        appointmentHeaderLabel.text = appointmentDetail.headerValue
        appointmentTextField.placeholder = appointmentDetail.placeholderValue
        appointmentTextField.keyboardType = .default

        if let value = value as? String {
            appointmentTextField.text = value
        } else {
            appointmentTextField.text = nil
        }

        switch appointmentDetail {
        case .time, .moveInDate:
            appointmentTextField.removeFromSuperview()
            stackView.addArrangedSubview(datePicker)

            if appointmentDetail == .moveInDate {
                datePicker.datePickerMode = .date
            }

            if let value = value as? Date {
                datePicker.date = value
            } else {
                datePicker.date = Date()
            }
        case .bedrooms, .bathrooms, .rent, .size, .zipCode:
            appointmentTextField.keyboardType = .numberPad
        case .phoneNumber:
            appointmentTextField.keyboardType = .phonePad
        case .email:
            appointmentTextField.keyboardType = .emailAddress
        default:
            break
        }
    }
}

// MARK: - UITextFieldDelegates

extension AppointmentInputTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let appointmentDetail = appointmentDetail else {
            fatalError("appointmentDetail should not be nil!")
        }

        delegate?.didUpdateCell(with: textField.text ?? "", appointmentDetail: appointmentDetail)
    }
}
