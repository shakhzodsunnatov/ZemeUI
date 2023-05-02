//
//  MyDocumentsView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 23/04/23.
//

import SwiftUI

struct MyDocumentsView: View {
    
    //MARK: - PROPERTIES
    let firsSection = [
        "Plaid Verified Bank Statement - Jan",
        "Plaid Verified Bank Statement - Feb",
        "Employment Verification",
        "W2 Form - 2022"
    ]
    
    var body: some View {
        NavigationNavBar(title: "My Documents") {
            ScrollView {
                VStack(spacing: 20) {
                    
                    ExpandingCell(text: "Agent Requested", isOpened: true, views: [
                        
                        makeCell(
                            image: "bank_ic",
                            title: firsSection[0],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                        makeCell(
                            image: "bank_ic",
                            title: firsSection[1],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                        makeCell(
                            image: "people_ic",
                            title: firsSection[2],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                        makeCell(
                            image: "document_ic",
                            title: firsSection[3],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                    
                    ])
                    
                    
                    ExpandingCell(text: "Other Documents", isOpened: true, views: [
                        
                        makeCell(
                            image: "bank_ic",
                            title: firsSection[0],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                        
                        makeCell(
                            image: "people_ic",
                            title: firsSection[2],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                        makeCell(
                            image: "document_ic",
                            title: firsSection[3],
                            subTitle: "Uploaded Jan. 7"
                        ).makeButton {
                            
                        },
                        
                    
                    ])
                    
                    ActionButton("Upload More Docs", action:  {
                        
                    })
                    .padding(.horizontal, 56)
                    .padding(.top, 21)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 23)
            }
        }
    }
}

//MARK: - UI

extension MyDocumentsView {
    
    private func makeCell(image: String, title: String, subTitle: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.darkBlue.opacity(0.15))
                )
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text(title)
                    .medium16
                    
                
                Text(subTitle)
                    .regular14
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Image(systemName: "chevron.right.circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(.darkBlue)
                .frame(width: 26, height: 26)
        }
    }
}

struct MyDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        MyDocumentsView()
    }
}
