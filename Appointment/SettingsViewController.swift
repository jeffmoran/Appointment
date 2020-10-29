//
//  SettingsViewController.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/15/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    // MARK: - Static Constants

    private static let tableViewCellIdentifier = "appointmentDetailCellIdentifier"

    // MARK: - Internal Properties

    weak var delegate: AppointmentListViewControllerDelegate?

    // MARK: - Initializers

    init() {
        super.init(style: .grouped)

        title = "Settings"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissViewController))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }

    private func removeAllAppointments() {
        let alertController = UIAlertController(
            title: "Are you sure?",
            message: "All appointments will be removed.",
            preferredStyle: .alert
        )

        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            AppointmentStore.shared.deleteAll()
            self.delegate?.refreshAppointmentList()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #warning("Rewritten from Obj-C -- clean this up")

        let cell = UITableViewCell(style: .value1, reuseIdentifier: SettingsViewController.tableViewCellIdentifier)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Delete all appointments"
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Sorting"
                cell.detailTextLabel?.text = "Date"
            default:
                break
            }
        default:
            break
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #warning("Rewritten from Obj-C -- clean this up")

        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                removeAllAppointments()
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:

                #warning("Implement, use UIMenu")

                let alertController = UIAlertController(title: nil, message: "The ascending order in which appointments are sorted.", preferredStyle: .actionSheet)

                let dateAction = UIAlertAction(title: "Date", style: .default, handler: { _ in

                })

                let nameAction = UIAlertAction(title: "Name", style: .default, handler: { _ in
                })

                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alertController.addAction(dateAction)
                alertController.addAction(nameAction)
                alertController.addAction(cancelAction)

                present(alertController, animated: true)
            default:
                break
            }
        default:
            break
        }
    }
}
