//
//  AppointmentInputSectionViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/1/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentInputSectionViewModel {

    // MARK: - Private Properties

    private let appointment: Appointment?
    private let section: AppointmentDetailSection
    private weak var delegate: AppointmentInputRowViewModelDelegate?

    // MARK: - Internal Properties

    lazy var rowViewModels: [AppointmentInputRowViewModel] = {
        section.rows.map {
            AppointmentInputRowViewModel(appointment, row: $0, delegate: self)
        }
    }()

    var title: String {
        return section.title
    }

    var numberOfRows: Int {
        return rowViewModels.count
    }

    // MARK: - Initializers

    init(_ appointment: Appointment?, section: AppointmentDetailSection, delegate: AppointmentInputRowViewModelDelegate) {
        self.appointment = appointment
        self.section = section
        self.delegate = delegate
    }
}

// MARK: - AppointmentInputRowViewModelDelegate

extension AppointmentInputSectionViewModel: AppointmentInputRowViewModelDelegate {
    func didUpdate(with value: Any, row: AppointmentDetailSectionRow) {
        delegate?.didUpdate(with: value, row: row)
    }
}
