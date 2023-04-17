//
//  ApplicationChecklist.swift
//  ReZeme
//
//  Created by Shakhzod on 16/03/23.
//

import SwiftUI

struct ApplicationChecklist: View {
    
    //MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var step = 0
    @State var isTermConformed = false
    @State var isActiveSubmitBtn = true
    
    
    //MARK: - body
    
    var body: some View {
        NavigationNavBar(title: "Application Checklist") {
            ScrollView(.vertical, showsIndicators: false) {
                
                AddingInviteEmailCard(delegate: self)
                    .padding(.horizontal,20)
                    .padding(.top, 22)
                
                
                RequestedDocCard(step: $step) { pressedStep in
                    
                }
                    .padding(.horizontal,20)
                    .padding(.top, 20)
                
                
                conformCheckBox($isTermConformed)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                
                
                uploadReviewButtons {
                    // Upload Button pressed action
                } review: {
                    // Review Button pressed action
                }
                .padding(.horizontal, 20)
                .padding(.top, 25)

                
                submitButton(isActive: $isTermConformed) {
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 17)
            }
            .frame(width: SCREEN_WIDTH)
        }
    }
}


//MARK: - InviteEmailCardDelegate

extension ApplicationChecklist: InviteEmailCardDelegate {

    func getEmails(_ emails: [String]) {
        debugPrint("Emails \(emails)")
    }
}


//MARK: - UI Components

extension ApplicationChecklist {
    
    private func navBar(geo: GeometryProxy) -> some View {
            HStack {
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .font(Font.title.weight(.medium))
                        .frame(width: 26, height: 26)
                }
                .padding(.leading, 17)
                
                Spacer()
                
                Text("Application Checklist")
                    .semibold22
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 43)
                
            }
            .padding(.top, geo.safeAreaInsets.top)
            .padding(.bottom, 25)
            .frame(width: SCREEN_WIDTH)
            .background(
                Image("top-background")
                    .resizable()
            )
            .ignoresSafeArea(edges: .top)
    }
    
    private func conformCheckBox(_ isConformed: Binding<Bool>) -> some View {
        Button(action: {
            isConformed.wrappedValue.toggle()
        }) {
            HStack(spacing: 9) {
                
                Image(systemName: isConformed.wrappedValue ? "checkmark.circle" : "circle")
                    .resizable()
                    .scaledToFill()
                    .font(.title.weight(.light))
                    .foregroundColor(.darkBlue)
                    .frame(width: 20, height: 20)
                
                Text("I’ve confirmed that everything is accurate")
                    .foregroundColor(.black)
                    .regular14
                
                Spacer()
            }
        }
    }
    
    private func uploadReviewButtons(upload: @escaping ()->Void, review: @escaping ()-> Void) -> some View {
        HStack(spacing: 17) {
            
            Button(action: upload) {
                Text("Upload More")
                    .semibold16
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
            }
            
            Button(action: review) {
                Text("Review")
                    .semibold16
                    .foregroundColor(.darkBlue)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .stroke(Color.darkBlue, lineWidth: 1)
                    )
            }
        }
    }
    
    private func submitButton(isActive: Binding<Bool>, action: @escaping ()-> Void) -> some View {
        NavigationLink(destination: CreditCheckView()) {
            Text("Submit Application")
                .semibold16
                .foregroundColor(.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(Color.purpleGradient.toLinearGradient)
                        .opacity(isActive.wrappedValue ? 1 : 0.4)
                )
        }
        .disabled(!isActive.wrappedValue)
    }
}

struct ApplicationChecklist_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationChecklist()
    }
}
