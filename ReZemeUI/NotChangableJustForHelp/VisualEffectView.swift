//
//  VisualEffectView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 18/04/23.
//

import SwiftUI
import UIKit


struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
