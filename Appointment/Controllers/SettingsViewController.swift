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

    // MARK: - Private Properties

    private weak var delegate: AppointmentListViewControllerDelegate?

    // MARK: - Initializers

    init(delegate: AppointmentListViewControllerDelegate) {
        self.delegate = delegate

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
            self.delegate?.didDeleteAllAppointments()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController {

    private func settingsSection(at index: Int) -> SettingsSection {
        guard let section = SettingsSection(rawValue: index) else {
            fatalError("Unable to create section!")
        }

        return section
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSection(at: section).numberOfRows
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSection(at: section).titleForHeader
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = settingsSection(at: indexPath.section)

        let cell = UITableViewCell(style: .value1, reuseIdentifier: SettingsViewController.tableViewCellIdentifier)

        let row = section.rows[indexPath.row]

        cell.textLabel?.text = row.title

        switch row {
        case SettingsDeleteSectionRow.delete:
            break
        case let row as SettingsSortSectionRow:
            row.update(cell)
        default:
            fatalError("Unimplemented row!")
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else {
            fatalError("Unable to create section!")
        }

        tableView.deselectRow(at: indexPath, animated: true)

        let row = section.rows[indexPath.row]

        switch row {
        case let row as SettingsDeleteSectionRow:
            switch row {
            case .delete:
                removeAllAppointments()
            }
        case let row as SettingsSortSectionRow:
            updateAppointmentSorting(row, indexPath: indexPath)
        default:
            fatalError("Unimplemented row!")
        }
    }

    private func updateAppointmentSorting(_ row: SettingsSortSectionRow, indexPath: IndexPath) {
        Config.appointmentSortingType = row.sortingType

        tableView.reloadSections([indexPath.section], with: .automatic)

        delegate?.refreshAppointmentList()
    }
}
