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
    @State var isActiveSubmitBtn = false
    @State var navigate = false
    
    //MARK: - body
    
    var body: some View {
        NavigationNavBar(title: "Application Checklist") {
            ScrollView(.vertical, showsIndicators: false) {
                
                AddingInviteEmailCard(delegate: self)
                    .padding(.horizontal,20)
                    .padding(.top, 22)
                
                
                RequestedDocCard(step: $step) { pressedStep in
                    if step < 4 {
                        step += 1
                        navigate.toggle()
                        isActiveSubmitBtn = step >= 3 && isTermConformed
                    }
                }
                    .padding(.horizontal,20)
                    .padding(.top, 20)
                
                SimpleTextCheckView(title: "I’ve confirmed that everything is accurate") { t in
                    isTermConformed = t
                    isActiveSubmitBtn = step >= 4 && isTermConformed
                }
                
                
                uploadReviewButtons {
                    // Upload Button pressed action
                } review: {
                    // Review Button pressed action
                }
                .padding(.horizontal, 20)

                
                submitButton(isActive: $isActiveSubmitBtn) {
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
            }
            .frame(width: SCREEN_WIDTH)
            
            NavigationLink(isActive: $navigate) {
                switch step {
                case 4: CreditCheckView()
                default:  VStack {
                    Image("no_applications")
                    Text("Plaid view")
                }
                }
            } label: {
                EmptyView()
            }

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
        NavigationLink(destination: CongratsView()) {
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
