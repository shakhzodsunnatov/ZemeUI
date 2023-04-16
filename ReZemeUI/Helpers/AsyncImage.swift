//
//  AsyncImage.swift
//  ReZeme
//
//  Created by Shakhzod on 12/04/23.
//

import SwiftUI



struct AsyncImage: View {
    
    //MARK: - PROPERTIES
    
    let url: String?
    let placeHolderState: AsyncImageType
    let placeHolderFor: AccountType
    
    private var assetColor: Color {
        placeHolderFor == .RENTER ? Color.darkBlue : Color.secondaryPurple
    }
    
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                if let urlStr = url,
                   let url = URL(string: urlStr)
                {
                    
                    if placeHolderState == .rectangle {
                        
                        ZStack {
                            
                            remoteImage(url: url) {
                                placeHolderRectangleImage
                            }
                            
                        }
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        
                    } else {
                        
                        remoteImage(url: url) {
                            placeHolderCircleImage
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Circle()
                                .fill(assetColor)
                                .opacity(0.2)
                        )
                        .overlay(
                            Circle()
                                .stroke(assetColor, lineWidth: 2)
                        )
                        
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipShape(Circle())
                        
                    }
                    
                } else {
                    placeHolderRectangleImage
                }
                
            }
            
        }
    }
}


//MARK: - UI Components

extension AsyncImage {
    
    var placeHolderRectangleImage: some View {
        VStack(spacing:35) {
            
            Image("zeme_logo")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
                .frame(maxWidth: .infinity)
            
            
            ProgressView()
                .scaleEffect(2, anchor: .center)
                .progressViewStyle(
                    CircularProgressViewStyle(tint: Color.darkBlue)
                )
        }
        .frame(maxHeight: .infinity)
        .padding(31)
        .background(
            Image(placeHolderFor == .AGENT ? "top-background-secondary" : "authBG")
                .resizable()
                .scaledToFill()
                .cornerRadius(radius: 8, corners: .allCorners)
                .opacity(0.4)
        )
        .clipped()
    }
    
    var placeHolderCircleImage: some View {
        ZStack {
            Image("zeme_logo_noText")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 36)
        }
    }
    
    private func remoteImage<someView: View>(url: URL, @ViewBuilder placeHolder: () -> someView) -> some View {
        AsyncImageTool(
            url: url,
            placeholder: placeHolder
        ) {
            Image(uiImage: $0)
                .resizable()
        }
        .scaledToFill()
    }
    
}


struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(
            url: "https://zeme-bucket.s3.amazonaws.com/users/agents/images/1/06f93f98-040.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAYDXRMINHJEZCOLSN%2F20230412%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Date=20230412T235811Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=a9f80cff65e108e394def3e438d1341793a477b71e0be35f4d426e4a5f1b55d0",
            placeHolderState: .rectangle,
            placeHolderFor: .RENTER
        )
            .frame(width: 85, height: 63)
    }
    
}
