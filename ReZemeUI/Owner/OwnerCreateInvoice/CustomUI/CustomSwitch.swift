//
//  CustomSwitch.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct CustomSwitch: View {
    
    var title: String
    var action: (Bool)->()
    @State var switchButton: Bool = false
   
    var body: some View {
        
        HStack {
            Text(title)
                .regular14
            
            Spacer()
            
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(switchButton ? LinearGradient(colors: [.gray.opacity(0.5)], startPoint: .trailing, endPoint: .top) : Color.blueGradient.toLinearGradient)
                    .frame(width: 40, height: 24)
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 14)
                    .padding(5)
                    .offset(x: switchButton ? -13 : 0)
                    .onTapGesture {
                        withAnimation {
                            switchButton.toggle()
                            action(switchButton)
                        }
                    }
            }
        }
        .padding(.vertical,10)
    }
}

struct CustomSwitch_Previews: PreviewProvider {
    static var previews: some View {
        CustomSwitch(title: "1234rte") { i in
            
        }
    }
}
