//
//  ThumbnailConverter.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 22/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

enum ThumbnailOrientation {
    case portrait
    case landscape
}

class ThumbnailConverter {
    
    static let shared = ThumbnailConverter()
    
    let variants:[ThumbnailOrientation: String] = [.portrait: "/portrait_fantastic",
                                                   .landscape: "/landscape_incredible"]
    
    func toURL(thumbnail: Thumbnail, orientation: ThumbnailOrientation) -> URL? {
        if let variant = variants[orientation] {
            let ext = thumbnail.thumbnailExtension
            let urlStr = thumbnail.path
                .appending(variant)
                .appending(".")
                .appending(ext)
            return URL(string: urlStr)
        }
        return nil
    }
}

extension Thumbnail {
    func toURL(orientation: ThumbnailOrientation) -> URL? {
        return ThumbnailConverter.shared.toURL(thumbnail: self, orientation: orientation)
    }
}

