//
//  ImageURLProtocol.swift
//  wwdc2021-playgroundTests
//  
//  Created by elmetal on 2021/06/13
//  
//

import Foundation
import UIKit

final class ImageURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        let response = HTTPURLResponse()
        let data = UIImage(systemName: "xmark")!.pngData()!
        
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: data)
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
