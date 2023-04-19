//
//  Haptic.swift
//  ReZeme
//
//  Created by Davron Usmanov on 10.04.2023.
//

import UIKit

class Haptic {
    
    class func generateMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    class func generateLight() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    class func generateSuccess() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    class func generateError() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    class func generateWarning() {
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
}
