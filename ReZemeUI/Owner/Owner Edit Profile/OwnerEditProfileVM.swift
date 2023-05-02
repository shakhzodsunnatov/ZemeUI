//
//  OwnerEditProfileVM.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 02.05.2023.
//

import Foundation
import PhotosUI

class OwnerEditProfileVM: ObservableObject {
    
    @Published var model = RegistrationInfoDM()
    @Published var openNextView = false
    
    @Published var fullname = false
    @Published var location = false
    @Published var middlename = false
    @Published var email = false
    @Published var phone = false
    @Published var password = false
    @Published var error = false
    @Published var company = false
    
    @Published var isShowPhotoLibrary = false
    @Published var image = UIImage(named: "person")
    
    @Published var isLoading = false
    @Published var errorTxt = ""
    
    @AutoFormatter(type: .phone) var phoneNumber: String
    
    func validate() -> Bool {
        // Reset any previous errors
        self.fullname =  self.model.name.isEmpty
        self.company =  self.model.lastname.isEmpty
        self.email =  self.model.email.isEmpty
        self.password = self.model.password.count <= 3
        self.location = self.model.location.isEmpty
        
        
        // Check for valid email address using regular expression
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        email = !emailPredicate.evaluate(with: self.model.email.uppercased())
        
        return [fullname,email,company, password, location].allSatisfy({ !$0 })
    }
}
