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

    lazy var cellViewModels: [AppointmentDetailCellViewModel] = AppointmentDetailType.allCases.map {
        AppointmentDetailCellViewModel(appointment, type: $0)
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
        return appointment.clientName
    }

    var numberOfRows: Int {
        return cellViewModels.count
    }

    var phoneUrl: URL? {
        let phoneNumber = appointment.clientPhone.filter("0123456789.".contains)

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
}
