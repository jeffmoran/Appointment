//
//  AppointmentListViewController.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/20/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

class AppointmentListViewController: UITableViewController {

    // MARK: - Private Properties

    private var appointments: [Appointment?] {
        return AppointmentStore.shared.allAppointments
    }

    // MARK: - Initializers

    init() {
        super.init(style: .insetGrouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Appointments"

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(goToSettings))

        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewAppointment))
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditing))

        navigationItem.rightBarButtonItems = [addItem, editItem]

        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: AppointmentTableViewCell.reuseIdentifier)
        tableView.allowsSelectionDuringEditing = true
    }

    // MARK: - Private Methods

    @objc private func goToSettings() {
        let viewController = SettingsViewController()
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)

        present(navigationController, animated: true)
    }

    @objc private func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)

        navigationItem.leftBarButtonItem?.isEnabled = !tableView.isEditing
    }

    @objc private func addNewAppointment() {
        let viewController = AppointmentInputViewController(with: nil)
        viewController.delegate = self

        let navigationController = UINavigationController(rootViewController: viewController)

        present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDatasource

extension AppointmentListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppointmentStore.shared.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.reuseIdentifier) as? AppointmentTableViewCell else {
            fatalError("Wrong cell type!")
        }

        if let appointment = appointments[indexPath.row] {
            cell.style(with: appointment)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let count = AppointmentStore.shared.count

        if count < 1 {
            return nil
        } else if count == 1 {
            return "1 Appointment"
        } else {
            return "\(count) Appointments"
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appointment = appointments[indexPath.row] else { return }

            AppointmentStore.shared.delete(appointment)

            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDelegate

extension AppointmentListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let appointment = appointments[indexPath.row] else { return }

        if tableView.isEditing {
            let viewController = AppointmentInputViewController(with: appointment)
            viewController.delegate = self

            let navigationController = UINavigationController(rootViewController: viewController)

            present(navigationController, animated: true)
        } else {
            let viewController = AppointmentDetailViewController(with: appointment)

            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - AppointmentListViewControllerDelegate

extension AppointmentListViewController: AppointmentListViewControllerDelegate {
    func refreshAppointmentList() {
        tableView.reloadData()
    }
}
