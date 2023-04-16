//
//  EnvironmentValues+ImageCache.swift
//  ZemeDesign
//
//  Created by Benjamin Kushmakov on 12/4/22.
//


import SwiftUI

public struct ImageCacheKey: EnvironmentKey {
    public static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
