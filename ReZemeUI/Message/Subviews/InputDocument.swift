//
//  InputDocument.swift
//  ReZemeUI
//
//  Created by Shakhzod on 17/04/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct InputDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.plainText] }
    
    var input: String
    
    init(input: String) {
        self.input = input
    }
    
    init(configuration: FileDocumentReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        input = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: input.data(using: .utf8)!)
    }
    
}


struct TestView: View {
    
    @State private var document: InputDocument = InputDocument(input: "")
    @State private var isImporting: Bool = false
    
    var body: some View {
        HStack {
            Button(action: { isImporting = true}, label: {
                Text("Push to browse to location of data file")
            })
            Text(document.input)
        }
        .padding()
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
                    
                    let isPDF = selectedFile.pathExtension.lowercased() == "pdf"
                    let pdfName = selectedFile.lastPathComponent
                    
                    if isPDF {
                        // PDF file selected
                    } else {
                        // Other file selected
                    }
                    
                    let isWordDoc = selectedFile.pathExtension.lowercased() == "doc" || selectedFile.pathExtension.lowercased() == "docx"
                    if isWordDoc {
                        // Word document selected
                    } else {
                        // Other file selected
                    }
                    
                    guard let input = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                    defer { selectedFile.stopAccessingSecurityScopedResource() }
                    
                    
                    document.input = input
                    
                    
                    
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
