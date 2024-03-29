//
//  SettingsViewController+Sections.swift
//  Appointment
//
//  Created by Jeffrey Moran on 11/4/20.
//  Copyright © 2020 Jeff Moran. All rights reserved.
//

import UIKit

protocol SettingsRow {
    var title: String { get }
}

extension SettingsViewController {

    enum SettingsSection: Int, CaseIterable {
        case delete
        case sort

        var numberOfRows: Int {
            switch self {
            case .delete:
                return SettingsDeleteSectionRow.allCases.count
            case .sort:
                return SettingsSortSectionRow.allCases.count
            }
        }

        var titleForHeader: String? {
            switch self {
            case .delete:
                return nil
            case .sort:
                return "Sort by (Ascending)"
            }
        }

        var rows: [SettingsRow] {
            switch self {
            case .delete:
                return SettingsDeleteSectionRow.allCases
            case .sort:
                return SettingsSortSectionRow.allCases
            }
        }
    }

    enum SettingsDeleteSectionRow: SettingsRow, CaseIterable {
        case delete

        var title: String {
            switch self {
            case .delete:
                return "Delete all appointments"
            }
        }
    }

    enum SettingsSortSectionRow: SettingsRow, CaseIterable {
        case time
        case name

        var title: String {
            switch self {
            case .time:
                return "Appointment Time"
            case .name:
                return "Client Name"
            }
        }

        var sortingType: AppointmentSortingType {
            switch self {
            case .time:
                return .timeAscending
            case .name:
                return .name
            }
        }

        func update(_ cell: UITableViewCell) {
            let sorting = Config.appointmentSortingType

            switch self {
            case .time:
                if sorting == .timeAscending {
                    cell.accessoryType = .checkmark
                }
            case .name:
                if sorting == .name {
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
}
