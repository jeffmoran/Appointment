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

    private let viewModel: AppointmentInputViewModel

    private weak var delegate: AppointmentListViewControllerDelegate?

    // MARK: - Initializers

    init(_ viewModel: AppointmentInputViewModel, delegate: AppointmentListViewControllerDelegate) {
        self.delegate = delegate

        self.viewModel = viewModel

        super.init(style: .grouped)

        viewModel.delegate = self
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

        title = viewModel.title

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    @objc private func saveButtonPressed() {
        view.endEditing(true)

        viewModel.save()
    }
}

// MARK: - UITableViewDataSource

extension AppointmentInputViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentInputTableViewCell.reuseIdentifier) as? AppointmentInputTableViewCell else {
            fatalError("Wrong cell type!")
        }

        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        cell.setUp(with: cellViewModel)

        return cell
    }
}

// MARK: - AppointmentInputCellViewModelDelegate

extension AppointmentInputViewController: AppointmentInputViewModelDelegate {
    func didSuccesfullySave() {
        dismissViewController()
        delegate?.refreshAppointmentList()
    }

    func didFailToSave(error: Error) {
        presentAlert(
            title: "Error saving",
            message: "Please try again. \(error.localizedDescription)"
        )
    }
}
