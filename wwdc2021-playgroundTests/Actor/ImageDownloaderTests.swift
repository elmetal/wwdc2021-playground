//
//  ImageDownloaderTests.swift
//  wwdc2021-playgroundTests
//  
//  Created by elmetal on 2021/06/13
//  
//

import XCTest
@testable import wwdc2021_playground

final class ImageDownloaderTests: XCTestCase {
    func test_image_nil() async {
        let sut = ImageDownloader(using: URLSession.shared)
        let url = URL(string: "https://example.com")!
        do {
            let image = try await sut.image(from: url)
            XCTAssertNil(image)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func test_image_not_nil() async {
        let configration = URLSessionConfiguration.ephemeral
        configration.protocolClasses = [ImageURLProtocol.self]
        let urlSession = URLSession(configuration: configration)
        
        let sut = ImageDownloader(using: urlSession)
        let url = URL(string: "https://example.com")!
        
        do {
            let image = try await sut.image(from: url)
            XCTAssertNotNil(image)
        } catch {
            XCTFail("\(error)")
        }
    }
}

