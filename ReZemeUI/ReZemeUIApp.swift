//
//  ReZemeUIApp.swift
//  ReZemeUI
//
//  Created by Shakhzod on 16/04/23.
//

import SwiftUI

@main
struct ReZemeUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var isRenter = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isRenter {
                    ContentView()
                } else {
                    NewContentView()
                }
            }
            .onTapGesture(count: 5) {
                isRenter.toggle()
            }
            .onAppear {
                ZemeFonts.registerFonts()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

