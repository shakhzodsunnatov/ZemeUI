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
                ContentView()
            }
            .onAppear {
                ZemeFonts.registerFonts()
            }
        }
    }
}
