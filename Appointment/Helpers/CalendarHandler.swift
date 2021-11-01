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
    static func createEvent(with viewModel: CalendarEmailViewModel, from viewController: UIViewController) {
        viewController.presentAlert(
            message: "Add appointment to Calendar?",
            dismissActionTitle: "Maybe later",
            defaultActionTitle: "Yes"
        ) {
                authorizeEventStore(with: viewModel, viewController: viewController)
        }
    }

    private static func authorizeEventStore(with viewModel: CalendarEmailViewModel, viewController: UIViewController) {
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
                event.title = viewModel.eventTitle
                event.location = viewModel.eventLocation
                event.notes = viewModel.eventDetailsString
                event.startDate = viewModel.eventStartDate
                event.endDate = viewModel.eventEndDate
                event.calendar = eventStore.defaultCalendarForNewEvents

                saveEvent(event: event, store: eventStore, viewModel: viewModel, viewController: viewController)
            @unknown default:
                break
            }
        }
    }

    private static func saveEvent(event: EKEvent, store: EKEventStore, viewModel: CalendarEmailViewModel, viewController: UIViewController) {
        let alertTitle: String?
        let alertMessage: String

        do {
            try store.save(event, span: .thisEvent)
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
