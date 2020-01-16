//
//  ImageWrapper.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import UIKit

enum ImageEncodingQuality: CGFloat {
    case png = 0
    case jpegLow = 0.2
    case jpegMid = 0.5
    case jpegHigh = 0.75
}

extension KeyedEncodingContainer {

    mutating func encode(_ value: UIImage,
                         forKey key: KeyedEncodingContainer.Key,
                         quality: ImageEncodingQuality = .png) throws {
        var imageData: Data!
        if quality == .png {
            imageData = value.pngData()
        } else {
            imageData = value.jpegData(compressionQuality: quality.rawValue)
        }
        try encode(imageData, forKey: key)
    }

}

extension KeyedDecodingContainer {

    public func decode(_ type: UIImage.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage {
        let imageData = try decode(Data.self, forKey: key)
        if let image = UIImage(data: imageData) {
            return image
        } else {
            throw SDKError.imageConversionError
        }
    }

}
class ImageWrapper: Codable, Equatable {
    static func == (lhs: ImageWrapper, rhs: ImageWrapper) -> Bool {
        lhs.uiImage == rhs.uiImage
    }
    

    private enum CodingKeys: String, CodingKey {
        case uiImage, encodingQuality
    }

    let uiImage: UIImage
    //let encodingQuality: ImageEncodingQuality
    
    init(uiImage: UIImage){
        self.uiImage = uiImage
        //self.encodingQuality = encodingQuality
         
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uiImage = try container.decode(UIImage.self, forKey: .uiImage)
        //encodingQuality = ImageEncodingQuality(rawValue: try container.decode(CGFloat.self, forKey: .encodingQuality))!
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uiImage, forKey: .uiImage, quality: .jpegHigh)
    }
}
