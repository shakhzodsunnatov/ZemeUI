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
    case buyer, agent, owner
    
    var bgImageStr: String {
        switch self {
        case .buyer: return "top-background"
        case .agent: return "top-background-secondary"
        case .owner: return "top-background-secondary"
            
        }
    }
}

enum UserType { //TODO: - remove and change with Account type enum
    case buyer, agent
}

enum AccountType: String {
    case RENTER
    case AGENT
    case OWNER
    
    var color: Color {
        switch self {
        case .RENTER: return Color.darkBlue
        case .AGENT: return Color.secondaryPurple
        case .OWNER: return Color.secondaryPurple
        }
    }
    
    var bgImageStr: String {
        switch self {
        case .RENTER: return "top-background"
        case .AGENT: return "top-background-secondary"
        case .OWNER: return "top-background-owner"
            
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
