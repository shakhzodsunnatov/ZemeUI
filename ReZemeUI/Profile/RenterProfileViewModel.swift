//
//  EditProfileViewModel.swift
//  ReZemeUI
//
//  Created by Shakhzod on 25/04/23.
//

import SwiftUI

class RenterProfileViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var location = ""
    @Published var workPlace = ""
    
}
