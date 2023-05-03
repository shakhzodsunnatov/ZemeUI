//
//  OwnerAddMaintenaceContactVM.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import Foundation

class OwnerAddMaintenaceContactVM: ObservableObject {
  
    @Published var model = RegistrationInfoDM()
    
    @Published var firstname = false
    @Published var lastname = false
    @Published var middlename = false
    @Published var email = false
    @Published var phone = false
    @Published var role = false
    @Published var confirmpassword = false
    @Published var error = false
    @Published var company = false
    
    
    func validate() -> Bool {
        // Reset any previous errors
        self.firstname =  self.model.name.isEmpty
        self.lastname =  self.model.lastname.isEmpty
        self.email =  self.model.email.isEmpty
        self.company =  self.model.company.isEmpty
        self.role = self.model.location.isEmpty
        
        
        
        // Check for valid email address using regular expression
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        email = !emailPredicate.evaluate(with: self.model.email.uppercased())
        
        return [firstname, lastname,email,company, role, confirmpassword].allSatisfy({ !$0 })
    }
}
