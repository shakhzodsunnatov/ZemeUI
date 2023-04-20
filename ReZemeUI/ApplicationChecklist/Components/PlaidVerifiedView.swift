//
//  PlaidVerifiedView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 20.04.2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct PlaidVerifiedView: View {
    
//    @State var files: [FileModel] = []
    @State var title: String = ""
    @State var isImporting = false
//    @EnvironmentObject var viewModel: ApplicationChecklistVM
    
    @Binding var modelforFile: RequestDocumentDM
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationNavBar(title: modelforFile.images) {
            ZStack {
                VStack {
                    ScrollView(.vertical) {
                        VStack {
                            ForEach((0..<modelforFile.fileAll.count), id: \.self) { index in
                                uploadFile(index: index)
                            }

                            Button {
                                isImporting.toggle()
                            } label: {
                                VStack{
                                    HStack {
                                        Spacer()
                                        VStack(spacing: 3) {
                                            
                                            Text("Tap to upload a photo")
                                                .medium16
                                            
                                            
                                            Text("You can add multiple photos")
                                                .medium12
                                            
                                        }
                                        Spacer()
                                    }
                                    .padding(.vertical,35)
                                    .background(Color.purpleLow.opacity(0.1))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.purpleLow, style: StrokeStyle(lineWidth: 1, dash: [3]))
                                    )
                                }
                                .padding(16)
                            }
                            .padding(.top,10)
                            .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    
                    linkButton(title: "Confirm Information") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(modelforFile.fileAll.isEmpty)
                    .opacity(!modelforFile.fileAll.isEmpty ? 1 : 0.5)
                    .padding(.horizontal,76)
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
                    let pdfName = selectedFile.lastPathComponent
                    
                    switch selectedFile.pathExtension.lowercased() {
                        
                    case "pdf", "doc", "docx":
                        
                        
                        do {
                            let data = try Data(contentsOf: selectedFile)
                            
                            let base64String = data.base64EncodedString()
                            
                            var copyFile = FileModel()
                            copyFile.name = pdfName
                            copyFile.fileStr = base64String
                            withAnimation {
                                modelforFile.fileAll.append(copyFile)
                            }
                            
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
    }
}

struct PlaidVerifiedView_Previews: PreviewProvider {
    static var previews: some View {
        PlaidVerifiedView(title: "s", modelforFile: .constant(.init(images: "2324", title: "232134", fileAll: [])))
    }
}

extension PlaidVerifiedView {
    
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
    
    func uploadFile(index: Int) -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    modelforFile.fileAll.remove(at: index)
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 10, height: 10)
                }
                .padding([.horizontal,.top])
            }
            HStack(spacing: 10) {
                Image("document_icon")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                
                Text(modelforFile.fileAll[index].name)
                    .bold14
               
                Spacer()
            }
            .padding(10)
        }
        .background(Color.white)
        .padding(.horizontal,16)
        .cornerRadius(10)
        .shadowCustom()
        .padding(.top,10)
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
