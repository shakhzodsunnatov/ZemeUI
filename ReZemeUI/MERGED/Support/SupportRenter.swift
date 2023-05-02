//
//  SupportRenter.swift
//  ReZemeUI
//
//  Created by Shakhzod on 23/04/23.
//

import SwiftUI

struct SupportRenter: View {
    
    //MARK: - PROPERTIES
    @State var subjectText = ""
    @State var messageText = ""
    
    var body: some View {
        NavigationNavBar(title: "Support") {
            ScrollView {
                VStack(spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 13) {
                        
                        Text("Frequently Asked Questions")
                            .semibold18
                            .multilineTextAlignment(.leading)
                        
                        ForEach((0..<4), id:\.self) { index in
                            ExpandingCell(
                                text: "How does Zeme work?",
                                image: UIImage(named: "support_ic"),
                                views: [
                                    placeHolderTextView
                                ]
                            )
                        }
                        
                    }
                    .padding(.top, 20)
                    
                    
                    VStack(spacing: 10) {
                        
                        Text("Contact Us")
                            .semibold18
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 0) {
                            
                            imageAndTitle(image: "document_ic", title: "Subject")
                            
                            TextField("Title", text: $subjectText)
                                .medium16
                                .autocorrectionDisabled()
                                .frame(height: 58)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.white)
                                        .glow()
                                )
                                .padding(.top, 11)
                            
                            
                            imageAndTitle(image: "edit", title: "Message")
                                .padding(.top, 22)
                            
                            
                            TextEditorWithPlaceholders(text: $messageText, placeHolder: .constant("Add a bio..."))
                                .frame(maxWidth: .infinity)
                                .frame(minHeight: 146)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 18)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.white)
                                        .glow()
                                )
                                .padding(.top, 11)
                            
                            
                            Text("Your message has been submitted and we will get back to you shortly!")
                                .regular14
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondaryPurple)
                                .padding(.vertical,9)
                                .padding(.horizontal, 15)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.secondaryPurple.opacity(0.15))
                                )
                                .padding(.top, 17)
                            
                            
                            ActionButton("Submit", action:  {
                                
                            })
                            .padding(.top, 22)
                            .padding(.horizontal, 25)
                            
                        }
                        .padding(
                            EdgeInsets(
                                top: 17,
                                leading: 18,
                                bottom: 27,
                                trailing: 18
                            )
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
                                .glow()
                        )
                        
                    }
                    .padding(.top, 16)
                    
                }
                .padding(.horizontal, 20)
                
            }
        }
    }
}


//MARK: - UI

extension SupportRenter {
    
    private var placeHolderTextView: some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
            .regular12
            .multilineTextAlignment(.leading)
            .padding(.bottom, 15)
    }
    
    private func imageAndTitle(image: String, title: String) -> some View {
        HStack(spacing: 7) {
            Image(image) //edit
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
            
            Text(title)
                .regular14
            
            Spacer()
        }
    }
    
    
}

struct SupportRenter_Previews: PreviewProvider {
    static var previews: some View {
        SupportRenter()
    }
}

struct TextEditorWithPlaceholders: View {
    @Binding var text: String
    @Binding var placeHolder: String
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(placeHolder)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .padding(.leading, 6)
                    //                            .opacity(0.1)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .frame(minHeight: 150, maxHeight: 300)
                    .opacity(text.isEmpty ? 0.7 : 1)
                Spacer()
            }
        }
    }
}


