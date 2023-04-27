//
//  OfferChat.swift
//  ReZeme
//
//  Created by Shakhzod on 25/03/23.
//

import SwiftUI

struct MeetingChat: View {
    
    //MARK: - PROPERTIES
    
    var date: Date
    @State var today = Date()
    let changeDateAction: (Date)-> Void
    let acceptAction: (Date) -> Void
    let denyAction: (Date) -> Void
    @State var mode:Bool = false
    var body: some View {
        
        VStack(spacing: 20) {
            
            headerTime
            
            LineView()
            
            HStack(spacing: 0) {
                
                changeDateButton(action: { mode.toggle() } )
                
                Spacer(minLength: 0)
                
                acceptButton(action: { acceptAction(date) } )
                
                Spacer(minLength: 0)
                
                denyButton(action: { denyAction(date) } )
            }
            
            
                if mode {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .roundedShadowNew()
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    mode.toggle()
                                }
                            }
                        DatePicker("select", selection: $today,in: Date()..., displayedComponents: .date)
                            .frame(width: 300 , height: 300)
                            .datePickerStyle(.graphical)
                            .zIndex(1)
                    }
                }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 13)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.darkBlue, lineWidth: 1)
        )
    }
    
}


//MARK: - UI Components
extension MeetingChat {
    
    private var headerTime: some View {
        HStack(spacing: 7) {
            
            Image("calendar")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            Text("Meeting Date")
                .foregroundColor(Color.textGray)
                .medium16
            
            Spacer()
            
            Text(self.today.setCurrentDate())
                .medium16
                .foregroundColor(.blue)
                .onChange(of: self.today) { newValue in
                    mode.toggle()
                }
            
        }
    }
    
    private func changeDateButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Text("Change")
                .foregroundColor(.darkBlue)
                .semibold14
                .padding(.horizontal, 15)
                .frame(height: 36)
                .frame(width: (SCREEN_WIDTH-92)/2.5)
                .background(
                    Capsule()
                        .fill(Color.lightBlue.opacity(0.2))
                )
        }
    }
    
    private func acceptButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            
            Text("Accept")
                .foregroundColor(.white)
                .semibold14
                .padding(.horizontal, 15)
                .frame(height: 36)
                .frame(width: (SCREEN_WIDTH-92)/3.2)
                .background(
                    Capsule()
                        .fill(Color.blueGradient.toLinearGradient)
                )
        }
    }
    
    private func denyButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Text("Deny")
                .foregroundColor(.darkBlue)
                .semibold14
                .padding(.horizontal, 15)
                .frame(height: 36)
                .frame(width: (SCREEN_WIDTH-92)/3.2)
                .background(
                    Capsule()
                        .stroke(Color.darkBlue, lineWidth: 1)
                )
        }
    }
    
    
    
}

struct MeetingChat_Previews: PreviewProvider {
    static var previews: some View {
        MeetingChat(
            date: Date(),
            changeDateAction: {_ in},
            acceptAction: {_ in},
            denyAction: {_ in}
        )
        .frame(height: 50)
    }
}

extension Date {
     func setCurrentDate() -> String {
        //          let date = Date()
        // Use this to add st, nd, th, to the day
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        numberFormatter.locale = Locale.current
        
        //Set other sections as preferred
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMM"
        
        // Works well for adding suffix
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        let dayString = dayFormatter.string(from: self)
        let monthString = monthFormatter.string(from: self)
        
        // Add the suffix to the day
        let dayNumber = NSNumber(value: Int(dayString)!)
        let day = numberFormatter.string(from: dayNumber)!
        
        return "\(monthString) \(day)"
    }
}
