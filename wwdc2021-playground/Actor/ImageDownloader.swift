//
//  ImageDownloader.swift
//  wwdc2021-playground
//  
//  Created by elmetal on 2021/06/13
//  
//

import SwiftUI

actor ImageDownloader {
    let urlSession: URLSession
    private var cache: [URL: Image] = [:]

    init(using urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func image(from url: URL) async throws -> Image? {
        if let cached = cache[url] {
            return cached
        }

        let image = try await downloadImage(from: url)

        // Potential bug: `cache` may have changed.
        cache[url] = image
        return image
    }
    
    private func downloadImage(from url: URL) async throws -> Image? {
        let (data, _) = try await urlSession.data(from: url)
        
        guard let uiImage = UIImage(data: data) else { return nil }
        return Image(uiImage: uiImage)
    }
}
