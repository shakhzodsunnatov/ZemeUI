//
//  SelectDocSheetView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 17/04/23.
//

import SwiftUI

struct SelectDocSheetView: ViewModifier {
    
    @Binding var isActive: Bool
    var indexSelectedAction: (Int)-> Void = {_ in}
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                    SelectDocumentTypeView(
                        closeAction: { isActive = false },
                        selectedIndex: { indexSelectedAction($0) }
                    )
                    .offset(y: self.isActive ? -geo.size.height / geo.size.height : geo.size.height)
                    .animation(.easeInOut(duration: 0.5))
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        
    }
}


extension View {
    
    func selectDocumentTypeView(
        isActive: Binding<Bool>,
        selectedIndex: @escaping (Int)-> Void
    ) -> some View {
        modifier(SelectDocSheetView(isActive: isActive, indexSelectedAction: selectedIndex))
    }
}

struct SelectDocSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
            
        }
        .selectDocumentTypeView(
            isActive: .constant(true),
            selectedIndex: {_ in})
    }
}
