//
//  CheckButtonCustom.swift
//  ReZeme
//
//  Created by Davron Usmanov on 03.04.2023.
//

import SwiftUI

struct CheckButtonCustom: View {
    
    @State var isSelected: Bool = false
    var title: String
    var action: (Bool)-> Void
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action(isSelected)
        }) {
            HStack(alignment: .lastTextBaseline, spacing: 0) {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.blue, lineWidth: 1)
                    .frame(width: 14, height: 14)
                    .padding(12)
                    .overlay(
                        Image(systemName: "checkmark")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.blue)
                            .frame(width: 8, height: 8)
                            .opacity(isSelected ? 1 : 0)
                    )
                
                Text(title)
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .regular14
            }
        }
    }
}

struct CheckButtonCustom_Previews: PreviewProvider {
    static var previews: some View {
        CheckButtonCustom(title: "123") { p in
            
        }
    }
}
