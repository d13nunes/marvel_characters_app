//
//  URLImage.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 18/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation
import UIKit

class URLImageView: UIImageView {
    
    private var imageDownloadTask: URLSessionDataTask?
    
    func setImage(fromThumbnail thumbnailOrNil: Thumbnail?, orientation: ThumbnailOrientation)  {
        if let thumbnail = thumbnailOrNil,
            let url = ThumbnailConverter.shared.toURL(thumbnail: thumbnail, orientation: orientation) {
            setImage(from: url)
        } else
        {
            image = UIImage()
        }
    }
    
    ///Downloads and set image from **url**. If download is not possible set an empty **UIImage()**
    func setImage(from urlOrNil: URL?)  {
        if let url = urlOrNil {
            imageDownloadTask = ImageLoader.shared.load(fromWebURL: url) { (aImage, fromUrl) in
                if let _ = aImage {
                    DispatchQueue.main.async {
                        self.image = aImage
                    }
                } else {
                    DispatchQueue.main.async {
                        self.image = UIImage()
                    }
                    debugPrint("error downloading image from url: \(fromUrl.absoluteString)")
                }
            }
        } else {
            image = UIImage()
        }
    }
    
    func cancelLoadingImage()  {
        if let task = imageDownloadTask {
            task.cancel()
        }
        imageDownloadTask = nil
    }
}
