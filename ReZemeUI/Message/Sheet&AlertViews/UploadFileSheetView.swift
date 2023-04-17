//
//  UploadFileSheetView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 17/04/23.
//

import SwiftUI

struct UploadFileSheetView: ViewModifier {
    
    @Binding var isActive: Bool
    @Binding var files: [FileModel]
    var addFileAction: ()->Void = {}
    var submit: ([FileModel])-> Void = { _ in}
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            GeometryReader { geo in
                VStack {
                    Spacer()
                    
                    UploadFileView(
                        isActive: $isActive,
                        files: $files,
                        closeAction: { isActive = false },
                        addFileAction: addFileAction,
                        submit: submit
                    )
                    .offset(y: self.isActive ? -geo.size.height / geo.size.height : geo.size.height)
                    .animation(.easeInOut(duration: 0.5))
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

//MARK: - Modifier

extension View {
    
    func uploadFileSheetView(
        isActive: Binding<Bool>,
        files: Binding<[FileModel]>,
        addFileAction: @escaping ()->Void,
        submit: @escaping ([FileModel])-> Void
    ) -> some View {
        modifier(
            UploadFileSheetView(
                isActive: isActive,
                files: files,
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
            files: .constant([]),
            addFileAction: {},
            submit: {_ in}
        )
    }
}
