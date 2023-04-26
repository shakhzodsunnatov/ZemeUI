//
//  PlaidVerifiedView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 20.04.2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct PlaidVerifiedView: View {
    
    @State var title: String = ""
    @State var isImporting = false
    @State var isShowPhotoLibrary = false
    @State var newdocument: String = ""
    @Binding var addNewModel: Bool
    @Binding var addFileEnable: Bool
    
    @State var image = UIImage(named: "person")!
    
    @State var newModel: RequestDocumentDM = .init(images: "New Documents", title: "document_icon", fileAll: [], imagesArray: [], addPhoto: true)
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ApplicationChecklistVM
    
    var body: some View {
        if addNewModel {
            NavigationNavBar(title: newModel.images) {
                ZStack {
                    VStack {
                        ScrollView(.vertical) {
                            VStack {
                                if newModel.fileAll.isEmpty || newModel.imagesArray.isEmpty {
                                    TextFieldWithIcon(image: "document_icon", topTitle: "Document title", text: $newdocument, textFiledStyle: .simple, emailError:.constant(false))
                                        .padding(10)
                                        .background(
                                            Color.white
                                                .cornerRadius(8)
                                                .shadowCustom()
                                        )
                                        .padding(20)
                                        .onChange(of: newdocument) { newValue in
                                            newModel.images = newValue
                                        }
                                }
                                
                                if addFileEnable {
                                    ForEach((0..<newModel.imagesArray.count), id: \.self) { index in
                                        uploadFileForImage(index: index)
                                    }
                                    
                                    photoSelectButton
                                        .onChange(of: self.image) { newValue in
                                            self.newModel.imagesArray.append(newValue)
                                        }
                                } else {
                                    ForEach((0..<newModel.fileAll.count), id: \.self) { index in
                                        uploadFile(index: index)
                                    }
                                    fileSelectButton
                                }
                            }
                        }
                        
                        Spacer()
                        
                        linkButton(title: "Confirm Information") {
                            if addNewModel {
                                let model:RequestDocumentDM = .init(images: self.newModel.images, title: self.newModel.title, fileAll: self.newModel.fileAll, imagesArray: self.newModel.imagesArray,addPhoto: self.addFileEnable, activate: true)
                                self.viewModel.models.append(model)
                                viewModel.step += 1
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                presentationMode.wrappedValue.dismiss()
                            }
                           
                            
                        }
                        .disabled(newModel.fileAll.isEmpty && newModel.imagesArray.isEmpty)
                        .opacity(!newModel.fileAll.isEmpty || !newModel.imagesArray.isEmpty ? 1 : 0.5)
                        .padding(.horizontal,76)
                    }
                    
                }
                
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            .onTapGesture {
                UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
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
                                    newModel.fileAll.append(copyFile)
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
        } else {
            NavigationNavBar(title: viewModel.models[viewModel.index].images) {
                ZStack {
                    VStack {
                        ScrollView(.vertical) {
                            VStack {
                                if viewModel.models[viewModel.index].addPhoto {
                                    ForEach((0..<viewModel.models[viewModel.index].imagesArray.count), id: \.self) { index in
                                        uploadFileForImage(index: index)
                                    }
                                    
                                    photoSelectButton
                                        .onChange(of: self.image) { newValue in
                                            self.viewModel.models[viewModel.index].imagesArray.append(newValue)
                                        }
                                } else {
                                    ForEach((0..<viewModel.models[viewModel.index].fileAll.count), id: \.self) { index in
                                        uploadFile(index: index)
                                    }
                                    fileSelectButton
                                }
                            }
                        }
                        
                        Spacer()
                        
                        linkButton(title: "Confirm Information") {
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                        .disabled(viewModel.models[viewModel.index].fileAll.isEmpty && viewModel.models[viewModel.index].imagesArray.isEmpty)
                        .opacity(!viewModel.models[viewModel.index].fileAll.isEmpty || !viewModel.models[viewModel.index].imagesArray.isEmpty ? 1 : 0.5)
                        .padding(.horizontal,76)
                    }
                    
                }
                
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
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
                                    viewModel.models[viewModel.index].fileAll.append(copyFile)
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
}

struct PlaidVerifiedView_Previews: PreviewProvider {
    static var previews: some View {
        PlaidVerifiedView(addNewModel: .constant(false), addFileEnable: .constant(false))
    }
}

extension PlaidVerifiedView {
    
    private var fileSelectButton: some View {
        Button {
            isImporting.toggle()
        } label: {
            VStack{
                HStack {
                    Spacer()
                    VStack(spacing: 3) {
                        
                        Text("Tap to upload a file")
                            .medium16
                        
                        
                        Text("You can add multiple files")
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
    
    private var photoSelectButton: some View {
        Button {
            self.isShowPhotoLibrary = true
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
                    if addNewModel {
                        self.newModel.fileAll.remove(at: index)
                    } else {
                        self.viewModel.models[viewModel.index].fileAll.remove(at: index)
                    }
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
                
                if addNewModel {
                    Text(self.newModel.fileAll[index].name)
                        .bold14
                } else {
                    Text(self.viewModel.models[viewModel.index].fileAll[index].name)
                        .bold14
                }
               
                
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
    
    func uploadFileForImage(index: Int) -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    if addNewModel {
                        self.newModel.imagesArray.remove(at: index)
                    } else {
                        self.viewModel.models[viewModel.index].imagesArray.remove(at: index)
                    }
                    
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
                
                if addNewModel {
                    
                    Image(uiImage: self.newModel.imagesArray[index])
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .padding(10)
                } else {

                    Image(uiImage: viewModel.models[viewModel.index].imagesArray[index])
                        .resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .padding(10)
                    
                }
                
               
                
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



