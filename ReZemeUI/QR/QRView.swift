//
//  QRView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 24.04.2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct QRView: View {
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        
        NavigationNavBar(title: "Share Property", type: .AGENT) {
            ZStack {
                Color.white
                VStack(spacing: 47) {
                    
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.purpleLow,lineWidth: 1)
                            .frame(width: 300, height: 300)
                            .overlay (
                                
                                Image(uiImage: generateQRCode(from: "Present this QR Code to allow \nfor buyer to apply for property"))
                                    .resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .frame(width: 260, height: 260)
                                
                            )
                        
                        Text("Present this QR Code to allow for buyer to apply for property")
                            .medium16
                            .foregroundColor(Color.purpleLow)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,32)
                            .padding(.vertical,20)
                            .background(Color.purpleLow.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal,20)
                        
                        ActionButton("Close", action:  {
                            print("asd")
                        })
                        .padding(.top,30)
                        .padding(.horizontal,45)
                    
                }
            }
            .cornerRadius(8)
            .padding(20)
            .roundedShadowNew()
        }
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}


extension QRView {
    
     func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
