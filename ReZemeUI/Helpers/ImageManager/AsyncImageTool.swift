//
//  ImageLoader.swift
//  ZemeDesign
//
//  Created by Benjamin Kushmakov on 12/4/22.
//

import SwiftUI

public struct AsyncImageTool<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder?
    private let image: (UIImage) -> Image
    
    public init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder? = { Image("testHouse").resizable() },
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    public var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}
