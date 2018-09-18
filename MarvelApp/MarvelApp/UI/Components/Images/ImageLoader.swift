//
//  File.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 17/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    
    static let  shared = ImageLoader();
    
    let imageCache: NSCache<NSString, UIImage>
    
    init() {
        imageCache = NSCache<NSString, UIImage>()
    }
    
    func load(fromWebURL url: URL, onCompletion: @escaping (_ image: UIImage?, _ fromURL: URL )->Void) -> URLSessionDataTask? {
        let urlString = url.absoluteString as NSString
        if let cachedImage = imageCache.object(forKey: urlString) {
            onCompletion(cachedImage, url)
            return nil
        } else {
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let aError = error {
                    debugPrint("Error loading image: \(aError.localizedDescription)")
                    onCompletion(nil, url)
                } else {
                    if let image = UIImage(data: data!) {
                        onCompletion(image, url)
                    } else {
                        onCompletion(nil, url)
                    }
                }
            };
            task.resume()
            return task
        }
    }
}
