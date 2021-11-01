//
//  ContactHandler.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/22/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import Contacts
import UIKit

enum ContactHandler {
    static func createContact(with viewModel: ContactViewModel, from viewController: UIViewController) {
        viewController.presentAlert(
            message: "Add \(viewModel.contactName) to Contacts?",
            dismissActionTitle: "Maybe later",
            defaultActionTitle: "Yes"
        ) {
                authorizeContactStore(with: viewModel, viewController: viewController)
        }
    }

    private static func authorizeContactStore(with viewModel: ContactViewModel, viewController: UIViewController) {
        let contactStore = CNContactStore()

        contactStore.requestAccess(for: .contacts) { _, _ in
            switch CNContactStore.authorizationStatus(for: .contacts) {
#warning("Handle error state")
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                let contact = CNMutableContact()
                contact.givenName = viewModel.contactName

                let phoneNumber = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: viewModel.contactPhone))
                contact.phoneNumbers = [phoneNumber]

                let emailAddress = CNLabeledValue(label: CNLabelHome, value: viewModel.contactEmail as NSString)
                contact.emailAddresses = [emailAddress]

                saveContact(contact: contact, store: contactStore, viewModel: viewModel, viewController: viewController)
            @unknown default:
                break
            }
        }
    }

    private static func saveContact(contact: CNMutableContact, store: CNContactStore, viewModel: ContactViewModel, viewController: UIViewController) {
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        let alertTitle: String?
        let alertMessage: String

        do {
            try store.execute(saveRequest)
            alertTitle = nil
            alertMessage = viewModel.successText
        } catch {
            alertTitle = viewModel.failureText
            alertMessage = error.localizedDescription
        }

        DispatchQueue.main.async {
            viewController.presentAlert(title: alertTitle, message: alertMessage)
        }
    }
}
