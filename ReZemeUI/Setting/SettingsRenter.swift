//
//  SettingsRenter.swift
//  ReZemeUI
//
//  Created by Shakhzod on 23/04/23.
//

import SwiftUI

struct SettingsRenter: View {
    
    private let sectionTitleStr = [
        "Edit Profile",
        "View My Documents",
        "Notification Settings",
        "Privacy Policy",
        "Terms and Conditions",
        "Support"
    ]
    private let images = [
        "profile-circle",
        "task-square",
        "notification",
        "shield-tick",
        "document-text",
        "messages_ic"
    ]
    
    @State var isOn = false
    
    var body: some View {
        NavigationNavBar(title: "Settings") {
            ScrollView {
             
                VStack(spacing: 15) {
                    ForEach((0..<sectionTitleStr.count), id: \.self) { index in
                        
                        ExpandingCell(
                            text: sectionTitleStr[index],
                            image: UIImage(named: images[index]),
                            views: [
                                makeSubView(text: sectionTitleStr[index], value: $isOn),
                                makeSubView(text: sectionTitleStr[index], value: $isOn),
                                makeSubView(text: sectionTitleStr[index], value: $isOn),
                            ]
                        )
                        
                    }
                }
                .padding([.horizontal, .top], 20)
            }
        }
    }
}

//MARK: - UI Components

extension SettingsRenter {
    
    private func makeSubView(text: String, value: Binding<Bool>) -> some View {
        Toggle(text, isOn: value)
            .foregroundColor(.black)
            .regular14
            .toggleStyle(SwitchToggleStyle(tint: Color.darkBlue))
            .frame(height: 30)
    }
}

struct SettingsRenter_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRenter()
    }
}
