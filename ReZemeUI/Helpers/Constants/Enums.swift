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
}

enum Method: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum AsyncImageType {
    case circle, rectangle
}

