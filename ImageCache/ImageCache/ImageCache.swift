//
//  ImageCache.swift
//  ImageCache
//
//  Created by Shahzaib Sarfraz on 12/8/20.
//

import Foundation
import UIKit

public class ImageCache {
    public var imageCache: [String: UIImage?] = [:]
    
    public init() { }
    
    public func returnCacheImage(imageUrl: URL) -> UIImage? {
        if let cachedImage = imageCache[imageUrl.absoluteString] {
            return cachedImage
        }
        else {
            return nil
        }
        
    }
    
    public func storeImageInCache(imageUrl: URL, image: UIImage) {
        self.imageCache[imageUrl.absoluteString] = image
    }
}
