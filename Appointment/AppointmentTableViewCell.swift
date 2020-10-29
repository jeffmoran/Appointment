//
//  AppointmentTableViewCell.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/14/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    // MARK: - Static Constants

    static let reuseIdentifier = "appointmentTableViewCellIdentifier"

    // MARK: - Private Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5.0

        return stackView
    }()

    private lazy var appointmentClientNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label

        return label
    }()

    private lazy var appointmentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel

        return label
    }()

    private lazy var appointmentAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiaryLabel

        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator

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
        stackView.addArrangedSubview(appointmentClientNameLabel)
        stackView.addArrangedSubview(appointmentTimeLabel)
        stackView.addArrangedSubview(appointmentAddressLabel)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)

        ])
    }

    // MARK: - Internal

    func style(with appointment: Appointment) {
        #warning("Rewritten from Obj-C -- clean this up")

        appointmentClientNameLabel.text = !appointment.clientName.isEmpty ? appointment.clientName : "Client name unavailable"

        let address = "\(appointment.address)\(appointment.zipCode)"
        appointmentAddressLabel.text = !address.isEmpty ? address : "Property address unavailable"

        appointmentTimeLabel.text = appointment.appointmentDateString
    }
}
