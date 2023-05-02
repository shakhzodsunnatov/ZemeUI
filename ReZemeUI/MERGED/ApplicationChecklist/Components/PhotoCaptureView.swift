//
//  PhotoCaptureView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 24/04/23.
//

import SwiftUI
import UIKit

struct PhotoCaptureView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var capturedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoCaptureView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<PhotoCaptureView>) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: PhotoCaptureView

        init(parent: PhotoCaptureView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.capturedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


//MARK: - How to use

//struct ContentView: View {
//    @State private var showCaptureView = false
//    @State private var capturedImage: UIImage?
//
//    var body: some View {
//        VStack {
//            if let image = capturedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                Text("No photo captured yet")
//            }
//
//            Button("Take Photo") {
//                self.showCaptureView = true
//            }
//        }
//        .sheet(isPresented: $showCaptureView) {
//            PhotoCaptureView(capturedImage: self.$capturedImage)
//        }
//    }
//}
