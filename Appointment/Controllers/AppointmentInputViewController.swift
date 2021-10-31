//
//  AppointmentInputViewController.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/27/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class AppointmentInputViewController: UITableViewController {

    // MARK: - Private Properties

    private var appointment: Appointment?

    private var store: CoreData<Appointment>

    private var valueMapping = [AppointmentDetail: Any?]()

    private weak var delegate: AppointmentListViewControllerDelegate?

    // MARK: - Initializers

    init(appointment: Appointment?, store: CoreData<Appointment>, delegate: AppointmentListViewControllerDelegate) {
        self.appointment = appointment
        self.store = store
        self.delegate = delegate

        valueMapping = [
            .name: appointment?.clientName,
            .email: appointment?.clientEmail,
            .phoneNumber: appointment?.clientPhone,
            .time: appointment?.appointmentTime,
            .address: appointment?.address,
            .zipCode: appointment?.zipCode,
            .city: appointment?.city,
            .moveInDate: appointment?.moveInDate,
            .pets: appointment?.pets,
            .rent: appointment?.price,
            .size: appointment?.size,
            .bedrooms: appointment?.roomsCount,
            .bathrooms: appointment?.bathsCount,
            .notes: appointment?.notes
        ]

        super.init(style: .grouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true

        tableView.allowsSelection = false
        tableView.register(AppointmentInputTableViewCell.self, forCellReuseIdentifier: AppointmentInputTableViewCell.reuseIdentifier)
        tableView.keyboardDismissMode = .interactive

        setUpNavigationBar()
    }

    // MARK: - Private Methods

    private func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        if let appointment = appointment {
            title = appointment.clientName
        } else {
            title = "New Appointment"
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))

        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))

        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearButtonPressed))

        navigationItem.rightBarButtonItems = [saveButton, clearButton]
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    @objc private func saveButtonPressed() {
        view.endEditing(true)

        let appointmentToSave: Appointment

        if let appointment = appointment {
            appointmentToSave = appointment
        } else {
            appointmentToSave = store.newObject
        }

        AppointmentDetail.allCases.forEach {
            let value = (valueMapping[$0] ?? "")

            let stringValue = (value as? String) ?? ""
            let dateValue = (value as? Date) ?? Date()

            switch $0 {
            case .name:
                appointmentToSave.clientName = stringValue
            case .email:
                appointmentToSave.clientEmail = stringValue
            case .phoneNumber:
                appointmentToSave.clientPhone = stringValue
            case .time:
                appointmentToSave.appointmentTime = dateValue
            case .address:
                appointmentToSave.address = stringValue
            case .zipCode:
                appointmentToSave.zipCode = stringValue
            case .city:
                appointmentToSave.city = stringValue
            case .moveInDate:
                appointmentToSave.moveInDate = dateValue
            case .pets:
                appointmentToSave.pets = stringValue
            case .rent:
                appointmentToSave.price = stringValue
            case .size:
                appointmentToSave.size = stringValue
            case .bedrooms:
                appointmentToSave.roomsCount = stringValue
            case .bathrooms:
                appointmentToSave.bathsCount = stringValue
            case .notes:
                appointmentToSave.notes = stringValue
            }
        }

        store.save()
        dismissViewController()
        delegate?.refreshAppointmentList()
    }

    @objc private func clearButtonPressed() {
        view.endEditing(true)
        valueMapping = [AppointmentDetail: Any]()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension AppointmentInputViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppointmentDetail.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentInputTableViewCell.reuseIdentifier) as? AppointmentInputTableViewCell else {
            fatalError("Wrong cell type!")
        }

        guard let appointmentDetail = AppointmentDetail(rawValue: indexPath.row) else {
            fatalError("Out of bounds error!")
        }

        let value = valueMapping[appointmentDetail] ?? ""

        cell.style(with: appointmentDetail, value: value)
        cell.delegate = self

        return cell
    }
}

// MARK: - AppointmentInputTableViewCellDelegate

extension AppointmentInputViewController: AppointmentInputTableViewCellDelegate {
    func didUpdateCell(with value: Any, appointmentDetail: AppointmentDetail) {
        valueMapping[appointmentDetail] = value
    }
}
