//
//  PlaidVerifiedView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 20.04.2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct PlaidVerifiedView: View {
    
    @Binding var isActive: Bool
    @Binding var files: [FileModel]
    var closeAction = {}
    var addFileAction = {}
    var submit: ([FileModel]) -> Void = { _ in}
    @State var title: String
    @State var showAlert = false
    @State var showSelectDocView = false
    @State var showFileUploadView = false
    @State var showMeetingTypeAlert = false
    @State var isImporting = false
    var body: some View {
        NavigationNavBar(title: title) {
            ScrollView(.vertical) {
                VStack {
                    
                    UploadFileView(
                        isActive: $isActive,
                        files: $files,
                        closeAction: { isActive = false },
                        addFileAction: { isImporting = true },
                        submit: submit, test: true
                    )
                    
                    
                }
                
            }
        }
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [
                .plainText, .pdf,
                UTType(filenameExtension: "doc")!,
                UTType(filenameExtension: "docx")!,
            ],
            allowsMultipleSelection: false
        ) { result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                if selectedFile.startAccessingSecurityScopedResource() {
                    
//                    guard let input = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                    let pdfName = selectedFile.lastPathComponent
                    
                    switch selectedFile.pathExtension.lowercased() {
                        
                    case "pdf", "doc", "docx":
                        
                        
                        do {
                            let data = try Data(contentsOf: selectedFile)
                            
                            let base64String = data.base64EncodedString()
                            
                            var copyFile = FileModel()
                            copyFile.name = pdfName
                            copyFile.fileStr = base64String
                            
                            files.append(copyFile)
                            
                        } catch {
                            print("Error: \(error.localizedDescription)")
                        }
                        
                    default: break
                    }
                    
                    do { selectedFile.stopAccessingSecurityScopedResource() }
                    
                } else {
                    // Handle denied access
                }
            } catch {
                // Handle failure.
                print("Unable to read file contents")
                print(error.localizedDescription)
            }
        }
//        .uploadFileSheetView(
//            isActive: $showFileUploadView,
//            addFileAction: {},
//            submit: { files in
//                
//                print(files.map({ $0.name })) // you can get here the base64 encode fileStr which you might send to server
//                showFileUploadView.toggle()
//            }
//        )
//        
//        .meetingTypeAlert(isActive: $showMeetingTypeAlert) { isVirtual in
//            print("IsVirtual \(isVirtual)")
//        }
    }
}

struct PlaidVerifiedView_Previews: PreviewProvider {
    static var previews: some View {
        PlaidVerifiedView(isActive: .constant(false), files: .constant([]), title: "s")
    }
}

extension PlaidVerifiedView {
    
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
}

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
