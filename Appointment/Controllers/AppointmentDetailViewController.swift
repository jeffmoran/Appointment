//
//  AppointmentDetailViewController.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/15/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import MessageUI
import UIKit

class AppointmentDetailViewController: UITableViewController {

    // MARK: - Private Properties

    private let viewModel: AppointmentDetailViewModel

    // MARK: - Initializers

    init(_ viewModel: AppointmentDetailViewModel) {
        self.viewModel = viewModel

        super.init(style: .grouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        tableView.allowsSelection = false
        tableView.register(AppointmentDetailTableViewCell.self, forCellReuseIdentifier: AppointmentDetailTableViewCell.reuseIdentifier)

        setUpMenu()
    }

    // MARK: - Private Methods

    private func setUpMenu() {
        let phoneAction = UIAction(title: "Call Client", image: UIImage(systemName: "phone")) { [weak self] _ in
            self?.callContact()
        }

        let emailAction = UIAction(title: "Email client", image: UIImage(systemName: "envelope")) { [weak self] _ in
            self?.showEmailComposer()
        }

        let mapAction = UIAction(title: "Find on map", image: UIImage(systemName: "mappin.and.ellipse")) { [weak self] _ in
            self?.showMapView()
        }

        let addContactAction = UIAction(title: "Add contact", image: UIImage(systemName: "person.crop.circle.badge.plus")) { [weak self] _ in
            self?.createNewContact()
        }

        let calendarAction = UIAction(title: "Add to Calendar", image: UIImage(systemName: "calendar.badge.plus")) { [weak self] _ in
            self?.createNewCalendarEvent()
        }

        var actions = [UIAction]()

        if viewModel.shouldShowPhoneAction {
            actions.append(phoneAction)
        }

        if viewModel.shouldShowEmailAction {
            actions.append(emailAction)
        }

        actions.append(contentsOf: [mapAction, addContactAction, calendarAction])

        let menu = UIMenu(children: actions)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)
    }

    private func callContact() {
        guard let phoneUrl = viewModel.phoneUrl else { return }

        UIApplication.shared.open(phoneUrl)
    }

    private func showEmailComposer() {
        EmailHandler.presentEmailComposer(viewModel: viewModel.calendarEmailViewModel, from: self)
    }

    private func showMapView() {
        let mapViewController = MapViewController(with: viewModel.mapViewModel)

        navigationController?.pushViewController(mapViewController, animated: true)
    }

    private func createNewContact() {
        ContactHandler.createContact(with: viewModel.contactViewModel, from: self)
    }

    private func createNewCalendarEvent() {
        CalendarHandler.createEvent(with: viewModel.calendarEmailViewModel, from: self)
    }
}

// MARK: - UITableViewDataSource

extension AppointmentDetailViewController {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentDetailTableViewCell.reuseIdentifier) as? AppointmentDetailTableViewCell else {
            fatalError("Wrong cell type!")
        }

        let cellViewModel = viewModel.cellViewModel(for: indexPath.section, rowIndex: indexPath.row)
        cell.setUp(with: cellViewModel)

        return cell
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension AppointmentDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
