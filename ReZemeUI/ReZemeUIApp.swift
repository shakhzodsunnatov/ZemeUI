//
//  ReZemeUIApp.swift
//  ReZemeUI
//
//  Created by Shakhzod on 16/04/23.
//

import SwiftUI

@main
struct ReZemeUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TestView()
            }
            .onAppear {
                ZemeFonts.registerFonts()
            }
        }
    }
}
