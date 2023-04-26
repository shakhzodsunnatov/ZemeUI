//
//  SimpleTextCheckView.swift
//  ReZeme
//
//  Created by Davron_Usmanov on 02.04.2023.
//

import SwiftUI

struct SimpleTextCheckView: View {
    
    @State var isSelected: Bool = false
    var title: String
    var type: UserType = .buyer
    var action: (Bool)-> Void
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action(isSelected)
        }) {
            HStack(spacing: 0) {
                Circle()
                    .stroke(type != .buyer ? Color.purpleLow : Color.blue, lineWidth: 1)
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .overlay(
                        Image(systemName: "checkmark" )
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(type != .buyer ? Color.purpleLow : Color.blue)
                            .opacity(isSelected ? 1 : 0)
                    )
                
                Text(title)
                    .foregroundColor(type != .buyer ? Color.purpleLow : Color.black)
                    .lineLimit(2)
                    .regular14
                
                Spacer()
            }
            .padding(.leading,16)
        }
    }
}

struct SimpleTextCheckView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTextCheckView(title:"Place holder" ) { i in
            
        }
    }
}

struct FileterCheckView: View {
    
    @Binding var isSelected: Bool
    var title: String
    var type: UserType = .buyer
    var action: (Bool)-> Void
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action(isSelected)
        }) {
            HStack(spacing: 0) {
                
                RoundedRectangle(cornerRadius: 6)
                    .stroke(type != .buyer ? Color.purpleLow : Color.blue, lineWidth: 1)
                    .frame(width: 20, height: 20)
                    .padding([.vertical,.trailing],12)
                    .overlay(
                        Image(systemName: "checkmark" )
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(type != .buyer ? Color.purpleLow : Color.blue)
                            .opacity(isSelected ? 1 : 0)
                            .padding([.vertical,.trailing],12)
                    )
                
                Text(title)
                    .foregroundColor(Color.black)
                    .lineLimit(2)
                    .medium16
            }
        }
        .padding(.leading,2)
    }
}

struct FileterCheckView_Previews: PreviewProvider {
    static var previews: some View {
        FileterCheckView(isSelected: .constant(false), title:"Place holder" ) { i in
            
        }
    }
}
