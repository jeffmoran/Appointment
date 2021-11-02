//
//  AppointmentListViewModel.swift
//  Appointment
//
//  Created by Jeffrey Moran on 10/31/21.
//  Copyright © 2021 Jeff Moran. All rights reserved.
//

import Foundation

class AppointmentListViewModel {

    // MARK: - Private Properties

    private let store = CoreDataStore<Appointment>()
    private var appointments = [Appointment]()

    // MARK: - Internal Properties

    var cellViewModels = [AppointmentListCellViewModel]()

    var title: String {
        return "Appointments"
    }

    var numberOfRows: Int {
        return cellViewModels.count
    }

    var titleForHeader: String? {
        if numberOfRows < 1 {
            return nil
        } else if numberOfRows == 1 {
            return "1 Appointment"
        } else {
            return "\(numberOfRows) Appointments"
        }
    }

    // MARK: - Initializers

    init() {
        refreshAppointments()
    }

    // MARK: - Internal Methods

    func refreshAppointments() {
        let sortingType = Config.appointmentSortingType.rawValue
        let sortDescriptor = NSSortDescriptor(key: sortingType, ascending: true)
        appointments = store.fetchAllObjects(with: [sortDescriptor])
        cellViewModels = appointments.map { AppointmentListCellViewModel($0) }
    }

    func deleteAppointment(at index: Int) throws {
        let appointment = appointments[index]
        try store.delete(appointment)
        refreshAppointments()
    }

    func deleteAllAppointments() {
        store.deleteAll()
        refreshAppointments()
    }

    func inputViewModel(for index: Int?) -> AppointmentInputViewModel {
        let viewModel: AppointmentInputViewModel

        if let index = index {
            let appointment = appointments[index]
            viewModel = AppointmentInputViewModel(appointment, store: store)
        } else {
            viewModel = AppointmentInputViewModel(nil, store: store)
        }

        return viewModel
    }

    func detailViewModel(for index: Int) -> AppointmentDetailViewModel {
        let appointment = appointments[index]
        return AppointmentDetailViewModel(appointment)
    }
}
