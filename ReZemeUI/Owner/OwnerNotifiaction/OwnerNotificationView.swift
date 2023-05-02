//
//  OwnerNotificationView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 02.05.2023.
//

import SwiftUI

struct OwnerNotificationView: View {
    
    @State var isActive: Bool = false
    @State var selectIndex: Int = 0
    
    var body: some View {
        CustomNavBar(
            content: {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    tabView()
                    
                    VStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { _ in
                            NotificationCell()
                        }
                    }
                    .padding(.bottom, 50)
                }
            },
            title: "Notifications",
            style: .newTitleAndIcon,
            type: .owner
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}


extension OwnerNotificationView {
    func tabView() -> some View{
        
        HStack(alignment: .center) {
            Button {
                withAnimation {
                    self.selectIndex = 0
                }
            } label: {
                Text("Listings")
                    .semibold14
                    .foregroundColor((self.selectIndex == 0) ? .white : Color(hexString: "545454"))
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background(
                        self.selectIndex == 0 ? Color.darkBlue : Color.white
                    )
                    .cornerRadius(8)
            }

            Button {
                withAnimation {
                    self.selectIndex = 1
                }
            } label: {
                Text("Service Requests")
                    .semibold14
                    .foregroundColor((self.selectIndex == 1) ? .white : Color(hexString: "545454"))
                    .frame(maxWidth: .infinity,maxHeight: 30)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                    .background((self.selectIndex == 1)  ? Color.darkBlue : Color.white)
                    .cornerRadius(8)
            }
        }
        .padding(EdgeInsets(top: 5, leading: 6, bottom: 4, trailing: 6))
        .background (
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hexString: "DBE1E3"),lineWidth: 1)
        )
        .padding(.top,10)
        .padding(.horizontal,20)
    }
}

struct OwnerNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerNotificationView()
    }
}
