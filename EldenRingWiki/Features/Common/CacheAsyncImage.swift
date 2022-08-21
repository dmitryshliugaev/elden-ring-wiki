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

class ImageCache {
    private let isolationQueue = DispatchQueue(label: "dmitryshliugaev.EldenRingWiki.concurrent-queue", attributes: .concurrent)
    private var cache: [String: Image] = [:]
    private let maxCount = 1000
    
    func setImage(_ image: Image?, key: String) {
        isolationQueue.async(flags: .barrier) {
            if self.cache.count > self.maxCount,
               let firstKey = self.cache.first?.key {
                self.cache.removeValue(forKey: firstKey)
            }
            self.cache[key] = image
        }
    }
    
    func getImage(forKey key: String)  -> Image? {
        var image: Image?
        
        isolationQueue.sync {
            image = cache[key]
        }
        
        return image
    }
}
