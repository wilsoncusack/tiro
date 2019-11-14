//
//  YPImagePickerController.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/11/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI
import YPImagePicker

struct YPRepresentable: UIViewControllerRepresentable{
    @Binding var items: [YPMediaItem]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<YPRepresentable>) -> YPImagePicker {
        var config = YPImagePickerConfiguration()
//        config.wordings.libraryTitle = "Gallery"
//        config.wordings.cameraTitle = "Camera"
//        config.wordings.next = "OK"
        config.library.maxNumberOfItems = 10
        config.screens = [.library, .photo]
        config.library.mediaType = .photo
        config.colors.filterBackgroundColor = UIColor.white
        config.icons.capturePhotoImage =  config.icons.capturePhotoImage.withTintColor(UIColor.gray)
        
        
        
        
        config.showsPhotoFilters = true
        config.onlySquareImagesFromCamera = false
        
        
        let picker = YPImagePicker(configuration: config)

        
        
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            for item in items {
                switch item {
                case .photo(let photo):
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            self.items = items
            picker.dismiss(animated: true, completion: nil)
        }
        return picker
    }
    
    func updateUIViewController(_ uiViewController: YPImagePicker, context: UIViewControllerRepresentableContext<YPRepresentable>) {
        
    }
    
    typealias UIViewControllerType = YPImagePicker
    
    
}
