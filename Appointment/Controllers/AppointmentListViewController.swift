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

    private let appointmentListViewModel = AppointmentListViewModel()

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

        title = appointmentListViewModel.title

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(goToSettings))

        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewAppointment))
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditing))

        navigationItem.rightBarButtonItems = [addItem, editItem]

        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: AppointmentTableViewCell.reuseIdentifier)
        tableView.allowsSelectionDuringEditing = true
    }

    // MARK: - Private Methods

    @objc private func goToSettings() {
        let viewController = SettingsViewController(delegate: self)

        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }

    @objc private func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)

        navigationItem.leftBarButtonItem?.isEnabled = !tableView.isEditing
        navigationItem.rightBarButtonItem?.isEnabled = !tableView.isEditing
    }

    @objc private func addNewAppointment() {
        let viewModel = appointmentListViewModel.inputViewModel(for: nil)

        let viewController = AppointmentInputViewController(viewModel, delegate: self)

        let navigationController = UINavigationController(rootViewController: viewController)

        present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDatasource

extension AppointmentListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentListViewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.reuseIdentifier) as? AppointmentTableViewCell else {
            fatalError("Wrong cell type!")
        }

        let viewModel = appointmentListViewModel.cellViewModels[indexPath.row]
        cell.setUp(with: viewModel)

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return appointmentListViewModel.titleForHeader
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try appointmentListViewModel.deleteAppointment(at: indexPath.row)

                tableView.performBatchUpdates {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            } catch {
                presentAlert(
                    title: "Error Deleting Appointment",
                    message: error.localizedDescription
                )
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension AppointmentListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            let viewModel = appointmentListViewModel.inputViewModel(for: indexPath.row)
            let viewController = AppointmentInputViewController(viewModel, delegate: self)

            let navigationController = UINavigationController(rootViewController: viewController)

            present(navigationController, animated: true)
        } else {
            let viewModel = appointmentListViewModel.detailViewModel(for: indexPath.row)
            let viewController = AppointmentDetailViewController(viewModel)

            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - AppointmentListViewControllerDelegate

extension AppointmentListViewController: AppointmentListViewControllerDelegate {
    func didDeleteAllAppointments() {
        appointmentListViewModel.deleteAllAppointments()
        tableView.reloadData()
    }

    func refreshAppointmentList() {
        appointmentListViewModel.refreshAppointments()
        tableView.reloadData()
    }
}
