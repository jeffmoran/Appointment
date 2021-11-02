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
        self.viewModel = viewModel
        self.delegate = delegate

        super.init(style: .insetGrouped)
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

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }

    @objc private func cancelButtonTapped() {
        viewModel.rollback()
        dismissViewController()
    }

    @objc private func saveButtonTapped() {
        view.endEditing(true)

        viewModel.save { result in
            switch result {
            case .success:
                dismissViewController()
                delegate?.refreshAppointmentList()
            case .failure(let error):
                presentAlert(
                    title: "Error saving",
                    message: error.localizedDescription
                )
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension AppointmentInputViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionViewModels[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionViewModels[section].numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentInputTableViewCell.reuseIdentifier) as? AppointmentInputTableViewCell else {
            fatalError("Wrong cell type!")
        }

        let cellViewModel = viewModel.cellViewModel(for: indexPath.section, rowIndex: indexPath.row)
        cell.setUp(with: cellViewModel)

        return cell
    }
}
