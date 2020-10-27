//
//  AppointmentDetailTableViewCell.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/15/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class AppointmentDetailTableViewCell: UITableViewCell {

    // MARK: - Static Constants

    static let reuseIdentifier = "appointmentDetailTableViewCellIdentifier"

    // MARK: - Private Properties

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIStackView.spacingUseSystem

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

    private lazy var appointmentValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)

        return label
    }()

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
        stackView.addArrangedSubview(appointmentValueLabel)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            appointmentHeaderLabel.widthAnchor.constraint(equalToConstant: 80),

            stackView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.readableContentGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.readableContentGuide.bottomAnchor)

        ])
    }

    // MARK: - Public Methods

    func style(with appointment: Appointment, index: Int) {
        let appointmentDetail = AppointmentDetail(rawValue: index)

        appointmentHeaderLabel.text = appointmentDetail?.headerValue
        appointmentValueLabel.text = appointmentDetail?.detailValue(for: appointment)
    }
}
