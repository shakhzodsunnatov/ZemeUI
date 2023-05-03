//
//  OwnerTransactionDetailView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct OwnerTransactionDetailView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    openView()
                    
                    Text("Player")
                        .semibold18
                    
                    personCell()
                }
                .padding(.top,20)
                .padding(.horizontal,20)
            }
            
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.white)
                .frame(height: 150)
                .overlay(
                    VStack(spacing: 16) {
                        
                        linkButton(title: "Request Payment",type: .RENTER) {
                            
                        }
                        
                        linkButton(title: "Mark as Paid", type: .RENTER, stoke: true) {
                            
                        }
                    }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 20))
                )
        }
        
        .navigationOwner(title: "Transaction Details")
    }
}

extension OwnerTransactionDetailView {
    func openView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Due on 15 Mar, 2023")
                    .semibold18
                Spacer()
                HStack(spacing: 5) {
                    Circle()
                        .fill(Color.darkBlue)
                        .frame(width: 14)
                    Text("Open")
                        .medium14
                }
            }
            LineView()
               
            
            VStack(alignment: .leading,spacing: 10) {
                
                Text("Rent for $1,000.00")
                    .medium16
                ZStack(alignment: .leading) {
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.purpleLow.opacity(0.1))
                        .frame(maxWidth: .infinity,maxHeight: 8)
                    
                   Circle()
                        .fill(Color.purpleLow)
                        .frame(width: 12)
                    
                }
                HStack {
                    Text("$1,000.00 left")
                        .regular12
                    Spacer()
                    Text("$0.00 Paid")
                        .regular12
                }
            }
            .padding(.top,15)
        }
        .padding(20)
        .roundedShadow()
    }
    
    func personCell() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color.purpleLow.opacity(0.1))
                        .frame(width: 54)
                    
                    Image("fillPersonIcon")
                        .resizable()
                        .frame(width: 38,height: 38)
                        .padding(.top,5)
                }
                
                VStack(alignment: .leading,spacing: 6) {
                    
                    Text("Elior Alayev")
                        .semibold16
                    
                    if #available(iOS 15.0, *) {
                        Text("alayev.elior@gmail.com")
                            .tint(.black.opacity(0.5))
                            .regular11
                    } else {
                        Text("alayev.elior@gmail.com")
                            .regular11
                    }
                        
                    
                    Text("+1 917-770-7717")
                        .regular11
                        .foregroundColor(.darkBlue)
                }
                 Spacer()
            }
        }
        .padding(20)
        .roundedShadow()
    }
    
    func linkButton(title: String,type:AccountType = .AGENT,stoke: Bool = false ,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                
                if stoke {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient,lineWidth: 1)
                        .frame(height: 60)
                        .overlay (
                            Text(title)
                                .foregroundColor(type == .AGENT ? Color.purpleLow : Color.darkBlue )
                                .bold18
                        )
                } else {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient)
                        .frame(height: 60)
                        .overlay (
                            Text(title)
                                .foregroundColor(.white)
                                .bold18
                        )
                }
            }
            
        }
    }
}

struct OwnerTransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerTransactionDetailView()
    }
}
