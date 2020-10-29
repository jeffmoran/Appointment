//
//  CalendarHandler.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/27/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import EventKit
import UIKit

enum CalendarHandler {
    static func createContact(with appointment: Appointment, viewController: UIViewController) {
        viewController.presentAlert(message: "Add appointment to Calendar?", dismissActionTitle: "Maybe later", defaultActionTitle: "Yes") {
            authorizeContactStore(with: appointment, viewController: viewController)
        }
    }

    private static func authorizeContactStore(with appointment: Appointment, viewController: UIViewController) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { _, _ in
            switch EKEventStore.authorizationStatus(for: .event) {
            #warning("Handle error state")

            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                let event = EKEvent(eventStore: eventStore)
                event.title = "\(appointment.appointmentDateString) appointment with \(appointment.clientName)"
                event.location = appointment.address
                event.notes = appointment.calendarNotesString
                event.startDate = appointment.appointmentTime
                event.endDate = Date(timeInterval: 3600, since: appointment.appointmentTime)
                event.calendar = eventStore.defaultCalendarForNewEvents

                saveEvent(event: event, store: eventStore, appointment: appointment, viewController: viewController)
            @unknown default:
                break
            }
        }
    }

    private static func saveEvent(event: EKEvent, store: EKEventStore, appointment: Appointment, viewController: UIViewController) {
        let alertTitle: String?
        let alertMessage: String

        do {
            try store.save(event, span: .thisEvent)
            alertTitle = nil
            alertMessage = "Appointment added to calendar!"
        } catch {
            alertTitle = "Appointment not added to calendar."
            alertMessage = error.localizedDescription
        }

        DispatchQueue.main.async {
            viewController.presentAlert(title: alertTitle, message: alertMessage)
        }
    }
}
