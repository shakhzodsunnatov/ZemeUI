//
//  Enums.swift
//  ReZeme
//
//  Created by Shakhzod on 28/03/23.
//

import SwiftUI
import Foundation

enum HeaderStyle {
    case title, filteredtitle, filteredinput, filteredstackedinput, customimagetitle, newAgentMainFilter, newTitleAndIcon, newSearchWithTitle
}

enum HeaderType {
    case buyer, agent
}

enum UserType { //TODO: - remove and change with Account type enum
    case buyer, agent
}

enum AccountType: String {
    case RENTER
    case AGENT
    
    var color: Color {
        switch self {
        case .RENTER: return Color.darkBlue
        case .AGENT: return Color.secondaryPurple
        }
    }
}

enum Method: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum AsyncImageType {
    case circle, rectangle
}

enum TimeFormatType: String, CaseIterable {
    case sec, min, hr
}

enum TimeType: String, CaseIterable {
    case AM,PM
}

enum PriorityType: String, CaseIterable {
    case high = "High priority"
    case low = "Low priority"
}
