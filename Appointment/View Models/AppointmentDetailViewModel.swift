//
//  AppointmentDetailViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation
import MessageUI.MFMailComposeViewController
import UIKit.UIApplication

class AppointmentDetailViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment

    // MARK: - Internal Properties

    lazy var sectionViewModels: [AppointmentDetailSectionViewModel] = AppointmentDetailSection.allCases.map {
        AppointmentDetailSectionViewModel(appointment, section: $0)
    }

    lazy var mapViewModel: MapViewModel = {
        MapViewModel(appointment)
    }()

    lazy var calendarEmailViewModel: CalendarEmailViewModel = {
        CalendarEmailViewModel(appointment)
    }()

    lazy var contactViewModel: ContactViewModel = {
        ContactViewModel(appointment)
    }()

    var title: String {
        return appointment.client.name
    }

    var numberOfSections: Int {
        return sectionViewModels.count
    }

    var phoneUrl: URL? {
        let phoneNumber = appointment.client.phoneNumber.filter("0123456789.".contains)

        guard !phoneNumber.isEmpty else { return nil }

        return URL(string: "telprompt:\(phoneNumber)")
    }

    var shouldShowPhoneAction: Bool {
        guard let phoneUrl = phoneUrl else { return false }

        return UIApplication.shared.canOpenURL(phoneUrl)
    }

    var shouldShowEmailAction: Bool {
        return MFMailComposeViewController.canSendMail()
    }

    // MARK: - Initializers

    init(_ appointment: Appointment) {
        self.appointment = appointment
    }

    // MARK: - Internal Methods

    func cellViewModel(for sectionIndex: Int, rowIndex: Int) -> AppointmentDetailRowViewModel {
        let section = sectionViewModels[sectionIndex]
        return section.rowViewModels[rowIndex]
    }
}
