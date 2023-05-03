//
//  AgentRegViewPageOneVM.swift
//  ReZeme
//
//  Created by Davron Usmanov on 04.04.2023.
//

import Combine
import SwiftUI
import PhotosUI

class OwnerRegistarionVM: ObservableObject {
    
    @Published var model = RegistrationInfoDM()
    @Published var openNextView = false
    
    @Published var firstname = false
    @Published var lastname = false
    @Published var middlename = false
    @Published var email = false
    @Published var phone = false
    @Published var password = false
    @Published var confirmpassword = false
    @Published var error = false
    @Published var company = false
    
    @Published var isShowPhotoLibrary = false
    @Published var image = UIImage(named: "person")!
    
    @Published var isLoading = false
    @Published var errorTxt = ""
    @Published var confirmPasswordText = ""
    
    @AutoFormatter(type: .phone) var phoneNumber: String
    
    
    
    func validate() -> Bool {
        // Reset any previous errors
        self.firstname =  self.model.name.isEmpty
        self.lastname =  self.model.lastname.isEmpty
        self.email =  self.model.email.isEmpty
        self.company =  self.model.company.isEmpty
        self.password = self.model.password.count <= 3
        
        
        
        
        // Check for valid email address using regular expression
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        email = !emailPredicate.evaluate(with: self.model.email.uppercased())
        
        return [firstname, lastname,email,company, password, confirmpassword].allSatisfy({ !$0 })
    }
    
}

