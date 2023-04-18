//
//  CreditCheckVM.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 18.04.2023.
//

import Foundation

class CreditCheckVM: ObservableObject {
    
    @Published var showAlert = false
    @Published var openCongratsView = false
    @Published var calenarMode: Bool = false
    @Published var date = Date()
    
    @Published var firstnameText = ""
    @Published var lastnameText = ""
    @Published var middlenameText = ""
    @Published var phoneText = ""
    @Published var dateofbirdthText = ""
    
    @Published var firstnamecheck = false
    @Published var lastnamecheck = false
    @Published var middlenamecheck = false
    @Published var phonecheck = false
    @Published var dateofbirdthcheck = false
    
    @Published var isConfirmed = false

    func validate() -> Bool {
        // Reset any previous errors
        self.firstnamecheck =  self.firstnameText.isEmpty
        self.lastnamecheck =  self.lastnameText.isEmpty
        self.middlenamecheck =  self.middlenameText.isEmpty
        self.phonecheck =  self.phoneText.count <= 10
        self.dateofbirdthcheck = self.dateofbirdthText.isEmpty
        
        return [firstnamecheck, lastnamecheck,middlenamecheck,phonecheck, dateofbirdthcheck].allSatisfy({ !$0 })
    }

}

