//
//  MessageAgent.swift
//  ReZeme
//
//  Created by Shakhzod on 23/03/23.
//

import SwiftUI

struct MessageRenter: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    @StateObject var viewModel = MessageRenterViewModel()
    
    @State var textMessage = ""
    @State var isTodoViewOpened = false
    @State var heightOfKeyboard: CGFloat = 0
    @State var scrollToEnd = false
    @State var showAlert = false
    @State var showSelectDocView = false
    @State var showFileUploadView = false
    
    @State var selectedFiles: [FileModel] = [
        FileModel(file: "W2 Form 2022", notes: ["Add Notes", "Add Notes 2"]),
        FileModel(file: "W2 old Form 2020", notes: ["Here old one", "example"])
    ]
    
    let options = ["Take Picture", "Select File", "Choose Photo"]
    
    var body: some View {
        NavigationNavBar(title: "Message Agent") {
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
                                        .padding(.top, 85)
                                    
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
                                .onAppear {
                                    scrollToEnd.toggle()
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
                                        viewModel.sendText(textMessage)
                                        textMessage = ""
                                        scrollToEnd.toggle()
                                    },
                                    fileBtnAction: {
                                        DispatchQueue.main.async {
                                            self.showAlert.toggle()
                                        }
                                    }
                                )
                            )
                            .padding(.horizontal, 20)
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
                    
                    viewToDo(openCloseValue: $isTodoViewOpened) {
                        isTodoViewOpened.toggle()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top,9)
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
            files: $selectedFiles,
            addFileAction: {},
            submit: { files in
                showFileUploadView.toggle()
            }
        )
    }
}

//MARK: - UI Components

extension MessageRenter {
    
    private func viewToDo(openCloseValue value: Binding<Bool>, action:@escaping ()->Void) -> some View {
        Button(action: action) {
            HStack {
                
                Spacer()
                
                Text("View To-DOs")
                    .semibold18
                    .foregroundColor(.primaryBlue)
                    .padding(.leading, 15)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.primaryBlue)
                    .frame(width: 20, height: 20)
                
                
            }
            .padding(.vertical,10)
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .stroke(Color.primaryBlue, lineWidth: 1)
            )
            .background(Color.white)
        }
    }
    
    private func chatItems(_ chats: [MessageType]) -> some View {
        VStack(spacing: 20) {
            
            ForEach((0..<chats.count), id: \.self) { index in
                ChatItem(messageType: chats[index])
            }
            
        }
    }
}

extension MessageRenter {
    func dismissKeyboard() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}

struct MessageAgent_Previews: PreviewProvider {
    static var previews: some View {
        MessageRenter()
    }
}
