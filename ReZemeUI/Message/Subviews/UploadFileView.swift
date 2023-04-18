//
//  UploadFileView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 17/04/23.
//

import SwiftUI

struct UploadFileView: View {
    
    //MARK: - PROPETIES
    
    @Binding var isActive: Bool
    @Binding var files: [FileModel]
    var closeAction = {}
    var addFileAction = {}
    var submit: ([FileModel]) -> Void = { _ in}
    
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelperForm()
    @State var heightOfKeyboard: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                headerUI(
                    image: "document_ic",
                    name: "W2 Forms",
                    action: closeAction
                )
                
                uploadedFilesUI(
                    files: files,
                    removeAction: { files.remove(at: $0) },
                    updateNote: { files[$1].notes.append($0) }
                )
                .padding(.top,27)
                
                buttons(
                    addFileAction: addFileAction,
                    submitAction: { submit(files) }
                )
                .padding(.top, 23)
                .padding(.horizontal, 15)
            }
            .padding(EdgeInsets(top: 23, leading: 22, bottom: 28, trailing: 22))
            .background(Color.white)
            .cornerRadius(radius: 8, corners: [.topLeft, .topRight])
            .glowHard()
            .frame(width: SCREEN_WIDTH)
            .rotationEffect(.degrees(180))
            .padding(.top,keyboardHeightHelper.keyboardHeight)
            .onChange(of: keyboardHeightHelper.keyboardHeight) { newValue in
                DispatchQueue.main.async {
                       withAnimation {
                           if newValue <= 20 {
                               self.heightOfKeyboard = 0
                           } else {
                               self.heightOfKeyboard = newValue - 20
                           }
                       }
                   }
            }

        }
        .rotationEffect(.degrees(180))
        .onTapGesture {
            dismissKeyboard()
        }
    }
}


//MARK: - UIComponents

extension UploadFileView {
    
    private func headerUI(
        image: String,
        name: String,
        action: @escaping ()->Void
    ) -> some View {
        HStack(spacing: 12) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.darkBlue.opacity(0.15))
                )
            
            Text(name)
                .medium16
            
            Spacer()
            
            Button(action: action) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFill()
                    .font(.title.weight(.light))
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    
    private func uploadedFilesUI(
        files: [FileModel],
        removeAction: @escaping (Int)->Void,
        updateNote: @escaping (String,Int)->Void
    ) -> some View {
        VStack(spacing: 23) {
            ForEach((0..<files.count), id: \.self) { index in
                
                UploadFileItem(
                    model: files[index],
                    removeAction: { removeAction(index) },
                    addNode: { note in
                        updateNote(note,index)
                    }
                )
                
            }
        }
    }
    
    
    private func buttons(
        addFileAction: @escaping ()->Void,
        submitAction:  @escaping ()->Void
    ) -> some View {
        HStack(spacing: 16) {
            Button(action: addFileAction) {
                Text("Add File")
                    .semibold16
                    .foregroundColor(.darkBlue)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .stroke(Color.darkBlue, lineWidth: 1)
                    )
            }
            
            Button(action: submitAction) {
                Text("Submit")
                    .semibold16
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
            }
        }
    }
}

//MARK: - UploadFileItem

extension UploadFileView {
    
    struct UploadFileItem: View {
        
        var model: FileModel
        var removeAction: ()->Void
        var addNode: (String)->Void
        
        @State var noteText = ""
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Text(model.name)
                        .medium16
                    
                    Button(action: removeAction) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFill()
                            .font(.title.weight(.light))
                            .frame(width: 22, height: 22)
                    }
                    
                    Spacer()
                    
                    Text("Ready to submit")
                        .regular12
                        .foregroundColor(.secondaryPurple)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(model.notes, id:\.self) { note in
                        Text(note)
                            .regular14
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.top, 13)
                
                TextField(
                    "Add a note...",
                    text: $noteText,
                    onCommit: {
                        addNode(noteText)
                        DispatchQueue.main.async {
                            self.noteText = ""
                            dismissKeyboard()
                        }
                    })
                .autocorrectionDisabled()
                .regular14
                .padding()
                .frame(height: 58)
                .padding(.top, 3)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .glow()
                )
                .padding(.top, 9)
            }
        }
    }
    
}


struct UploadFileView_Previews: PreviewProvider {
    static var previews: some View {
        UploadFileView(isActive: .constant(false), files: .constant([]))
    }
}
