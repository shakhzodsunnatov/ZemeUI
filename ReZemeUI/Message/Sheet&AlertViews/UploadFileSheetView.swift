//
//  UploadFileSheetView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 17/04/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct UploadFileSheetView: ViewModifier {
    
    @Binding var isActive: Bool
    @State var files: [FileModel] = []
    var addFileAction: ()->Void = {}
    var submit: ([FileModel])-> Void = { _ in}
    
    @State var isImporting = false
            
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isActive)
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    UploadFileView(
                        isActive: $isActive,
                        files: $files,
                        closeAction: { isActive = false },
                        addFileAction: { isImporting = true },
                        submit: submit
                    )
                    .offset(y: self.isActive ? -geo.size.height / geo.size.height : geo.size.height)
                    .animation(.easeInOut(duration: 0.5))
                    
                }
                .edgesIgnoringSafeArea(.bottom)
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
    }
}

//MARK: - Modifier

extension View {
    
    func uploadFileSheetView(
        isActive: Binding<Bool>,
        addFileAction: @escaping ()->Void,
        submit: @escaping ([FileModel])-> Void
    ) -> some View {
        modifier(
            UploadFileSheetView(
                isActive: isActive,
                addFileAction: addFileAction,
                submit: submit
            )
        )
    }
}

struct UploadFileSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            
        }
        .uploadFileSheetView(
            isActive: .constant(true),
            addFileAction: {},
            submit: {_ in}
        )
    }
}


import Combine

final class KeyboardHeightHelperForm: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        let keyboardWillShowPublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let keyboardWillHidePublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        keyboardWillShowPublisher
            .merge(with: keyboardWillHidePublisher)
            .compactMap { notification -> CGFloat? in
                if notification.name == UIResponder.keyboardWillShowNotification,
                   let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return keyboardFrame.height
                } else {
                    return 0
                }
            }
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] height in
                self?.keyboardHeight = height
            }
            .store(in: &cancellables)
    }
}
