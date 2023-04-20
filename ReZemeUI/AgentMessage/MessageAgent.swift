//
//  MessageAgent.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import SwiftUI

struct MessageAgent: View {
    
    //MARK: - PROPETIES
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    @StateObject var viewModel = MessageAgentViewModel()
    
    @State var textMessage = ""
    @State var heightOfKeyboard: CGFloat = 0
    @State var scrollToEnd = false
    
    //MARK: - Presenters
    @State var showAlert = false
    @State var showSelectDocView = false
    @State var showFileUploadView = false
    @State var showMeetingTypeAlert = false
    
    //MARK: - Protocols
    
    let options = ["Take Picture", "Select File", "Choose Photo"]
    
    var body: some View {
        NavigationNavBar(title: "Message Agent", type: .AGENT) {
            GeometryReader { geo in
                ZStack(alignment: .top) {
                    
                    ZStack(alignment: .bottom) {
                    
                        VStack(spacing:0) {
                            
                            ScrollViewReader { scrollViewProxy in
                                ScrollView(.vertical, showsIndicators: false) {
                                    
                                    Text("Today")
                                        .medium14
                                        .foregroundColor(.textGray)
                                        .padding(.vertical,9)
                                        .padding(.top, 75)
                                    
                                    chatItems(viewModel.messages)
                                        .padding(.horizontal, 20)
                                        .padding(.bottom, 100)
                                }
                                .padding(.bottom, heightOfKeyboard+60)
                                .onChange(of: scrollToEnd) { _ in
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            scrollViewProxy.scrollTo(viewModel.messages.count-1, anchor: .bottom)
                                        }
                                    }
                                }
                                .onTapGesture {
                                    dismissKeyboard()
                                }
                            }
                        }
                        
                        TextField("Type a message...", text: $textMessage)
                            .autocorrectionDisabled()
                            .textFieldStyle(
                                ChatTextFiledStyle(
                                    sendBtnAction: {
                                        guard !textMessage.isEmpty else { return }
                                        viewModel.sendText(textMessage)
                                        textMessage = ""
                                        scrollToEnd.toggle()
                                    },
                                    fileBtnAction: {
                                        DispatchQueue.main.async {
                                            self.dismissKeyboard()
                                            self.showAlert.toggle()
                                        }
                                    }
                                )
                            )
                            .padding(.horizontal, 18)
                            .offset(y: -max(heightOfKeyboard - geo.safeAreaInsets.bottom, geo.safeAreaInsets.bottom))
                            .onChange(of: self.keyboardHeightHelper.keyboardHeight) { newValue in
                                DispatchQueue.main.async {
                                       withAnimation {
                                           if newValue <= 20 {
                                               self.heightOfKeyboard = geo.safeAreaInsets.bottom
                                               self.scrollToEnd.toggle()
                                           } else {
                                               self.heightOfKeyboard = newValue - 20
                                               self.scrollToEnd.toggle()
                                           }
                                       }
                                   }
                            }
                    }
                    .background(Color.white)
                    .ignoresSafeArea()
                    
                    proposalButtons(
                        rent: {},
                        meeting: {}
                    )
                }
            }
        }
        .actionSheet(isPresented: $showAlert) {
            ActionSheet(title: Text("Select an option"),
                        buttons: [
                            .default(
                                Text(options[0]), // "Take Picture"
                                action: { }
                            ),
                            .default(
                                Text(options[1]), // "Select File"
                                action: {
                                    self.showAlert.toggle()
                                    self.showSelectDocView.toggle()
                                }
                            ),
                            .default(
                                Text(options[2]), // "Choose Photo"
                                action: { }
                            ),
                        ] + [.cancel()])
        }
        .selectDocumentTypeView(isActive: $showSelectDocView) { selectedIndex in
            switch selectedIndex {
            case 0: break       // Plaid Verified Bank Statements
            
            case 1:             // W2 Forms
                showSelectDocView.toggle()
                showFileUploadView.toggle()
            
            case 2: break       // Employment Verification
            case 3: break       // Paystubs
            default: break
            }
        }
        
        .uploadFileSheetView(
            isActive: $showFileUploadView,
            addFileAction: {},
            submit: { files in
                
                print(files.map({ $0.name })) // you can get here the base64 encode fileStr which you might send to server
                showFileUploadView.toggle()
            }
        )
        
        .meetingTypeAlert(isActive: $showMeetingTypeAlert) { isVirtual in
            print("IsVirtual \(isVirtual)")
        }
    }
}


//MARK: - AgentChatTypesProtocol - PROTOCOL

extension MessageAgent: AgentChatTypesProtocol {
    
    //MARK: - Offer
    
    func deleteOffer(_ offer: OfferChatModel) {}
    
    func changeOffer(_ offer: OfferChatModel) {}
    
    //MARK: - Meeting
    
    func changeMeetingDate(_ date: Date) {}
    
    func deleteMeetingDate(_ date: Date) {}
    
    //MARK: - Reminder
    
    func sendReminder() {}
    
}


//MARK: - UI Components

extension MessageAgent {
    
    private func chatItems(_ chats: [MessageType]) -> some View {
        VStack(spacing: 20) {
            
            ForEach((0..<chats.count), id: \.self) { index in
                AgentChatItem(
                    messageType: chats[index],
                    chatDelegates: self
                )
            }
        }
    }
    
    private func proposalButtons(rent: @escaping ()-> Void, meeting: @escaping ()->Void ) -> some View {
        HStack(spacing: 11) {
            
            Button(action: rent) {
                HStack(spacing: 6) {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    Text("Rent Proposal")
                        .foregroundColor(.darkBlue)
                        .semibold14
                }
                .frame(height: 36)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .stroke(Color.darkBlue)
                )
            }
            
            Button(action: meeting) {
                HStack(spacing: 6) {
                    Image("calendar_white")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    Text("Meeting Proposal")
                        .semibold14
                }
                .foregroundColor(.white)
                .frame(height: 36)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(Color.blueGradient.toLinearGradient)
                )
            }
        }
        .padding(18)
        .background(Color.white)
        .glow()
    }
}

extension MessageAgent {
    func dismissKeyboard() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}

struct MessageAgent_Previews: PreviewProvider {
    static var previews: some View {
        MessageAgent()
    }
}
