//
//  TransactionDetails.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 30.04.2023.
//

import SwiftUI

struct TransactionDetails: View {
    
    var body: some View {
        
        VStack(alignment: .leading) {
            topView()
                .padding(.horizontal,16)
            mediumView()
                .padding(.horizontal,20)
            
        }
        .padding(10)
        .roundedShadowNew()
        .padding(20)
        .navigationRenter(title: "Transaction Details")
    }
}

extension TransactionDetails {
    
    func topView() -> some View {
        VStack {
            HStack(alignment: .center) {
                Text("Rent January")
                    .semibold22
                
                Spacer()
                
                HStack {
                    Image("checked")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.green)
                        .frame(width: 15, height: 15)
                    Text("Paid on time")
                        .medium14
                }
            }
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 3.5)
                    .fill(Color.secondaryPurple.opacity(0.2))
                    .frame(height: 7)
                
                HStack(spacing: 0) {
                    
                    RoundedRectangle(cornerRadius: 3.5)
                        .fill(Color.secondaryPurple)
                        .frame(maxWidth: .infinity, maxHeight: 7)
                    
                    
                    Circle()
                        .fill(Color.secondaryPurple)
                        .padding(1)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                        .frame(width: 12, height: 12)
                }
                
            }
            
            HStack(alignment: .center) {
                Text("Rent for $1,423.44")
                    .medium16
                
                Spacer()
                
                Text("Paid on time")
                    .regular12
            }
        }
    }
    
    func mediumView() -> some View {
        VStack(alignment: .leading, spacing: 25) {
            LineView()
                .padding(.horizontal,34)
            mediumCell(title: "Payment Amount", value: "$1,400")
            mediumCell(title: "Convenience Fee", value: "$23.44")
            mediumCell(title: "Total", value: "1,423.44",purlpe: true)
            
            LineView()
                .padding(.horizontal,34)
            
            mediumCell(title: "Confirmation #", value: "33241")
            mediumCell(title: "Transaction Date", value: "15 Mar 2023")
            
            LineView()
                .padding(.horizontal,34)
            
            VStack(alignment: .leading,spacing: 4) {
                Text("Additional Notes")
                    .regular12
                
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                    .semibold14
                    .padding(.bottom,130)
            }
        }
    }
    
    func mediumCell(title: String, value: String, purlpe: Bool = false) -> some View {
        HStack{
            Text(title)
                .regular12
                
            Spacer()
            
            Text(value)
                .semibold14
                .foregroundColor(purlpe ? Color.purple : Color.black)
        }
    }
}

struct TransactionDetails_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetails()
    }
}
