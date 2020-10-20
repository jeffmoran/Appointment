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

    private var appointment: Appointment

    private var phoneUrl: URL? {
        let phoneNumber = (appointment.clientPhone ?? "").filter("0123456789.".contains)

        return URL(string: "telprompt:\(phoneNumber)")
    }

    private var shouldShowPhoneAction: Bool {
        guard let phoneUrl = phoneUrl else { return false }

        return UIApplication.shared.canOpenURL(phoneUrl)
    }

    // MARK: - Initializers

    @objc init(with appointment: Appointment) {
        self.appointment = appointment

        super.init(style: .grouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = appointment.clientName

        tableView.allowsSelection = false
        tableView.register(AppointmentDetailTableViewCell.self, forCellReuseIdentifier: AppointmentDetailTableViewCell.reuseIdentifier)

        setUpMenu()
    }

    // MARK: - Private Methods

    private func setUpMenu() {
        let phoneAction = UIAction(title: "Call Client", image: UIImage(systemName: "phone")) { _ in
            self.callContact()
        }

        let emailAction = UIAction(title: "Email client", image: UIImage(systemName: "envelope")) { _ in
            self.showEmailComposer()
        }

        let mapAction = UIAction(title: "Find on map", image: UIImage(systemName: "mappin.and.ellipse")) { _ in
            self.goToMapView()
        }

        let addContactAction = UIAction(title: "Add contact", image: UIImage(systemName: "person.crop.circle.badge.plus")) { _ in
            self.createNewContact()
        }

        let calendarAction = UIAction(title: "Add to Calendar", image: UIImage(systemName: "calendar.badge.plus")) { _ in
            self.createNewCalendarEvent()
        }

        var actions = [UIAction]()

        if shouldShowPhoneAction {
            actions.append(phoneAction)
        }

        if MFMailComposeViewController.canSendMail() {
            actions.append(emailAction)
        }

        actions.append(contentsOf: [mapAction, addContactAction, calendarAction])

        let menu = UIMenu(children: actions)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), menu: menu)
    }

    private func callContact() {
        guard let phoneUrl = phoneUrl else { return }

        UIApplication.shared.open(phoneUrl)
    }

    private func showEmailComposer() {
        let controller: MFMailComposeViewController! = MFMailComposeViewController()

        controller.navigationBar.tintColor = .white

        controller.mailComposeDelegate = self

        let subject = "\(appointment.appointmentDateString ?? "") Appointment with \(appointment.clientName ?? "")"
        controller.setSubject(subject)

        controller.setToRecipients([appointment.clientEmail ?? ""])

        controller.setMessageBody(appointment.emailBodyString, isHTML: true)

        present(controller, animated: true)
    }

    private func goToMapView() {
        let addressString = "\(appointment.address ?? "") \(appointment.zipCode ?? "")"

        let mapViewController = MapViewController(with: addressString)

        navigationController?.pushViewController(mapViewController, animated: true)
    }

    private func createNewContact() {
        ContactHandler.createNewContact(with: appointment, on: self)
    }

    private func createNewCalendarEvent() {
        CalendarEventHandler.createNewCalendarEvent(with: appointment, on: self)
    }
}

// MARK: - UITableViewDataSource

extension AppointmentDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointment.appointmentProperties.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentDetailTableViewCell.reuseIdentifier) as? AppointmentDetailTableViewCell else {
            fatalError("Wrong cell type!")
        }

        cell.style(with: appointment, index: indexPath.row)

        return cell
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension AppointmentDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
