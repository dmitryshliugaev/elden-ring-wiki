//
//  CacheAsyncImage.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 21/08/2022.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let content: (AsyncImagePhase) -> Content
    
    init(url: URL,
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }
    
    var body: some View {
        if let cached = Dependencies.shared.imageCache.getImage(forKey: url.absoluteString) {
            content(.success(cached))
        } else {
            AsyncImage(url: url) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success (let image) = phase {
            Dependencies.shared.imageCache.setImage(image, key: url.absoluteString)
        }
        return content(phase)
    }
}

class StructWrapper<T>: NSObject {
    let value: T
    
    init(_ _struct: T) {
        value = _struct
    }
}

class ImageCache {
    private var cache: NSCache<NSString, StructWrapper<Image>>
    
    init() {
        cache = NSCache<NSString, StructWrapper<Image>>()
        cache.countLimit = 5000
    }
    
    func setImage(_ image: Image, key: String) {
        cache.setObject(StructWrapper(image), forKey: NSString(string: key))
    }
    
    func getImage(forKey key: String)  -> Image? {
        let imageWrapper = cache.object(forKey: NSString(string: key))
        return imageWrapper?.value
    }
}
