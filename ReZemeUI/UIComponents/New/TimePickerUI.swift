//
//  TimePickerUI.swift
//  ReZemeUI
//
//  Created by Shakhzod on 28/04/23.
//

import SwiftUI

struct TimePickerUI: View {
    
    @Binding var time: Int
    var selectedTypeClosure: ((TimeFormatType)-> Void)? = nil
    
    @State var selectedTimeTypeIndex: Int = 2
    private let timeTypes = TimeFormatType.allCases
    
    var body: some View {
        HStack(spacing: 0) {
            
            HStack {
                
                Image(systemName: "minus")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.darkBlue)
                    .padding(13)
                    .frame(width: 40, height: 40)
                    .roundedShadow(backgroundColor: Color.darkBlue.opacity(0.25))
                    .makeButton {
                        if $time.wrappedValue > 1 {
                            $time.wrappedValue -= 1
                        }
                    }
                
                Spacer()
                
                Text(String(format: "%02d", $time.wrappedValue))
                    .semibold18
                
                Spacer()
                
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.darkBlue)
                    .padding(13)
                    .frame(width: 40, height: 40)
                    .roundedShadow(backgroundColor: Color.darkBlue.opacity(0.25))
                    .makeButton {
                        if $time.wrappedValue < 60 {
                            $time.wrappedValue += 1
                        }
                    }
            }
            
            if let selectedTypeClosure {
                HStack(spacing: 6) {
                    
                    Picker(
                        selection: $selectedTimeTypeIndex,
                        label:
                            Text("Time Type")
                            .foregroundColor(.black)
                            .medium16
                    ) {
                        ForEach((0..<timeTypes.count), id:\.self) { index in
                            Text(self.timeTypes[index].rawValue)
                                .medium16
                                .foregroundColor(.black)
                                .tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.black)
                    
                }
                .frame(width: 80)
                .onChange(of: selectedTimeTypeIndex) { newValue in
                    let type = timeTypes[newValue]
                    selectedTypeClosure(type)
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 7, bottom: 10, trailing: 7))
        .roundedShadow()
        
    }
}

struct TimePickerUI_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerUI(time: .constant(0))
    }
}
