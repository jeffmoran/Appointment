//
//  AppointmentDetailSection.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

enum AppointmentDetailSection: Int, CaseIterable {
    case contact
    case appointment
    case property

    var rows: [AppointmentDetailSectionRow] {
        switch self {
        case .contact:
            return AppointmentDetailSectionContactRow.allCases
        case .appointment:
            return AppointmentDetailSectionAppointmentRow.allCases
        case .property:
            return AppointmentDetailSectionPropertyRow.allCases
        }
    }

    var title: String {
        switch self {
        case .contact:
            return "Contact"
        case .appointment:
            return "Appointment Info"
        case .property:
            return "Property"
        }
    }
}
