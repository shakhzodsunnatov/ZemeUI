//
//  ApplicationChecklist.swift
//  ReZeme
//
//  Created by Shakhzod on 16/03/23.
//

import SwiftUI

struct ApplicationChecklist: View {
    
    //MARK: - PROPERTIES
    @State var showAlert = false
    let options = ["Take Picture", "Select File", "Choose Photo"]
    @Environment(\.presentationMode) var presentationMode
    
    @State var step = 0
    @State var index = 0
    @State var isTermConformed = false
    @State var isActiveSubmitBtn = false
    @State var navigate = false
    
    @State var trl = ""
    
    @State var files: [FileModel] = []
    var addFileAction: ()->Void = {}
    var submit: ([FileModel])-> Void = { _ in}
    @State var isImporting = false
    @State var showAlertt = false
    @State var isConfirmed = false
    
    @State var models: [RequestDocumentDM] = [
        .init(images: "Plaid Verified Bank State", title: "bank_ic"),
        .init(images: "Employment Verification", title: "people_ic"),
        .init(images: "W2 Form", title: "document_ic"),
        .init(images: "Credit Check",title: "speed_ic"),
    ]
    
    
    //MARK: - body
    
    var body: some View {
        NavigationNavBar(title: "Application Checklist") {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    
                    AddingInviteEmailCard(delegate: self)
                        .padding(.horizontal,20)
                        .padding(.top, 22)
                    
                    if !models.isEmpty {
                        RequestedDocCard(models: $models, textFiled: $trl, step: $step, tappedStep: { index in
                            if step < 4 {
                                step += 1
                                isActiveSubmitBtn = step >= 3 && isTermConformed
                            }
                            self.index = index
                            navigate.toggle()
                        },deleteStep: { index in
                            models.remove(at: index)
                        })
                            .padding(.horizontal,20)
                            .padding(.top, 20)
                    }
                    
                    SimpleTextCheckView(title: "I’ve confirmed that everything is accurate") { t in
                        isTermConformed = t
                        isActiveSubmitBtn = step >= 4 && isTermConformed
                    }
                    
                    
                    uploadReviewButtons {
                        showAlert.toggle()
                        self.models.append(.init(images: "New Documents", title: "document_icon"))
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
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Select an option"),
                                buttons: [
                                    .default(
                                        Text(options[0]), // "Take Picture"
                                        action: { self.showAlert = false }
                                    ),
                                    .default(
                                        Text(options[1]), // "Select File"
                                        action: {
                                            self.showAlert = false
                                            
    //                                        self.showSelectDocView.toggle()
                                        }
                                    ),
                                    .default(
                                        Text(options[2]), // "Choose Photo"
                                        action: { self.showAlert = false }
                                    ),
                                ] + [.cancel()])
                }
                
                
                if showAlertt {
                    ZStack() {
                        // faded background
                        Color.black.opacity(0.35)
                            .blur(radius: 4)
                            .edgesIgnoringSafeArea(.all)

                        ZStack(alignment: .topTrailing) {
                            
                            VStack(spacing: 0) {
                                
                                Image(systemName: "exclamationmark.triangle")
                                    .resizable()
                                    .scaledToFill()
                                    .font(.title.weight(.light))
                                    .foregroundColor(Color.secondaryPurple)
                                    .padding(22)
                                    .frame(width: 80, height: 80)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.secondaryPurple.opacity(0.15))
                                    )
                                    
                                Text("Notice!")
                                    .semibold18
                                    .padding(.top, 18)
                                
                                ScrollView(showsIndicators: false) {
                                    Text("By checking the  box below, you authorize us to obtain a soft inquiry credit report for the purpose of providing it to brokers, agents, landlords, property managers, and other relevant parties (collectively ) associated with the properties you are interested in. This soft inquiry credit report may include information on your credit history, payment records, and other information relevant to your creditworthiness. Soft inquiry credit reports do not affect your credit score and are not visible to other creditors. You understand that this information may be used by stakeholders to evaluate your application, and that Zeme Inc. is not responsible for any decisions made by stakeholders based on this information.")
                                        .regular16
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 7)
                                }.frame(maxHeight: 300)
                                
                                SimpleTextCheckView(title: "I authorize the soft credit inquiry") { t in
                                    isConfirmed = t
                                }
                                
                                linkButton(title: "Confirm") {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .disabled(!isConfirmed)
                                .opacity(!isConfirmed ? 0.5 : 1)
                                .padding(.horizontal,84)
                                
                            }
                            .padding(EdgeInsets(top: 35, leading: 28, bottom: 26, trailing: 28))
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                            )
                            .padding(.horizontal, 20)
                            
                            Button(action: {
                                showAlertt = false
                            }) {
                                Image("closeXIcon")
                                    .frame(width: 25,height: 25)
                            }
                            .padding(.trailing, 12)
                            .padding(.top, -7)
                        }
                        
                    }
                }
            }
            
            
            
            
            NavigationLink(isActive: $navigate) {
                switch index {
                case 3: CreditCheckView()
                default:  PlaidVerifiedView(isActive: .constant(false), files: .constant([]),title: models[index].images)
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
    
    func linkButton(title: String,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                Color.blueGradient.toLinearGradient
                    
                Text(title)
                    .foregroundColor(.white)
                    .bold18
            }
            .frame(height: 60)
            .cornerRadius(30)
        }
    }
}

struct ApplicationChecklist_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationChecklist()
    }
}
