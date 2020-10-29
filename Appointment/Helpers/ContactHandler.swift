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
    static func createContact(with appointment: Appointment, viewController: UIViewController) {
        viewController.presentAlert(message: "Add \(appointment.clientName) to Contacts?", dismissActionTitle: "Maybe later", defaultActionTitle: "Yes") {
            authorizeContactStore(with: appointment, viewController: viewController)
        }
    }

    private static func authorizeContactStore(with appointment: Appointment, viewController: UIViewController) {
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
                contact.givenName = appointment.clientName

                let phoneNumber = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: appointment.clientPhone))
                contact.phoneNumbers = [phoneNumber]

                let emailAddress = CNLabeledValue(label: CNLabelHome, value: appointment.clientEmail as NSString)
                contact.emailAddresses = [emailAddress]

                saveContact(contact: contact, store: contactStore, appointment: appointment, viewController: viewController)
            @unknown default:
                break
            }
        }
    }

    private static func saveContact(contact: CNMutableContact, store: CNContactStore, appointment: Appointment, viewController: UIViewController) {
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)

        let alertTitle: String?
        let alertMessage: String

        do {
            try store.execute(saveRequest)
            alertTitle = nil
            alertMessage = "\(appointment.clientName) saved to Contacts!"
        } catch {
            alertTitle = "Contact not Saved"
            alertMessage = error.localizedDescription
        }

        DispatchQueue.main.async {
            viewController.presentAlert(title: alertTitle, message: alertMessage)
        }
    }
}
