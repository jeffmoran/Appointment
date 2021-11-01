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

    private var viewModel: AppointmentInputCellViewModel?

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

    // MARK: - Internal Properties

    weak var delegate: AppointmentInputCellViewModelDelegate?

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
        guard let detailType = viewModel?.detailType else {
            fatalError("detailType should not be nil!")
        }

        delegate?.didUpdate(with: datePicker.date, type: detailType)
    }

    // MARK: - Internal Methods

    func setUp(with viewModel: AppointmentInputCellViewModel) {
        self.viewModel = viewModel
        delegate = viewModel

        appointmentHeaderLabel.text = viewModel.headerValue
        appointmentTextField.placeholder = viewModel.placeholderValue
        appointmentTextField.keyboardType = viewModel.keyboardType

        if let value = viewModel.value as? String {
            appointmentTextField.text = value
        } else if let value = viewModel.value as? Date {
            datePicker.date = value
        }

        switch viewModel.displayMode {
        case .textField:
            datePicker.removeFromSuperview()
            stackView.addArrangedSubview(appointmentTextField)
        case .datePicker:
            appointmentTextField.removeFromSuperview()
            stackView.addArrangedSubview(datePicker)
        }

        if let datePickerMode = viewModel.datePickerMode {
            datePicker.datePickerMode = datePickerMode
        }
    }
}

// MARK: - UITextFieldDelegates

extension AppointmentInputTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let detailType = viewModel?.detailType else {
            fatalError("detailType should not be nil!")
        }

        delegate?.didUpdate(with: textField.text ?? "", type: detailType)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let delegate = viewModel?.textFieldDelegate else {
            return true
        }

        return delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    }
}
