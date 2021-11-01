//
//  EmailHandler.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation
import MessageUI
import UIKit

enum EmailHandler {
    static func presentEmailComposer<T: UIViewController & MFMailComposeViewControllerDelegate>(viewModel: CalendarEmailViewModel, from viewController: T) {
        let controller: MFMailComposeViewController! = MFMailComposeViewController()

        controller.navigationBar.tintColor = .white

        controller.mailComposeDelegate = viewController

        let subject = viewModel.eventTitle
        controller.setSubject(subject)
        controller.setToRecipients([viewModel.emailAddress])
        controller.setMessageBody(viewModel.eventDetailsString, isHTML: true)

        viewController.present(controller, animated: true)
    }
}
