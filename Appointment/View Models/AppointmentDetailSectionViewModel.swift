//
//  AppointmentDetailSectionViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentDetailSectionViewModel {
    private let appointment: Appointment
    private let section: AppointmentDetailSection

    lazy var rowViewModels: [AppointmentDetailRowViewModel] = {
        section.rows.map {
            AppointmentDetailRowViewModel(appointment, row: $0)
        }
    }()

    var title: String {
        return section.title
    }

    var numberOfRows: Int {
        return rowViewModels.count
    }

    init(_ appointment: Appointment, section: AppointmentDetailSection) {
        self.appointment = appointment
        self.section = section
    }
}
