//
//  Gallery.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/11/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI
import Gallery
import Photos



struct GalleryPicker: UIViewControllerRepresentable {
    @Binding var showGallery: Bool
    @Binding var showLightbox: Bool
    @Binding var images : [Gallery.Image]
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GalleryPicker>) -> GalleryController {
        Gallery.Config.tabsToShow = [.cameraTab]
        Gallery.Config.Camera.imageLimit = 10
        
        
        let gallery = GalleryController()
        gallery.cart.images = images
        
        gallery.delegate = context.coordinator
        //present(gallery, animated: true, completion: nil)
         return gallery
       
    }
    
    func updateUIViewController(_ uiViewController: GalleryController, context: UIViewControllerRepresentableContext<GalleryPicker>) {
        
        uiViewController.cart.reload(images)
//        uiViewController.cart.images = images
        
        
    }
    
    func makeCoordinator() -> GalleryPicker.Coordinator  {
       return Coordinator(self)
    }
    
    class Coordinator: GalleryControllerDelegate {
        var parent: GalleryPicker
        
        init(_ parent: GalleryPicker){
            self.parent = parent
        }
        
        func galleryController(_ controller: GalleryController, didSelectImages images: [Gallery.Image]) {
            print("did select images")
            for i in images{
                print(i.asset)
            }
        }
        
        
        
        func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
            print("did select video")
        }
        
        func galleryController(_ controller: GalleryController, requestLightbox images: [Gallery.Image]) {
            self.parent.images = images 
            self.parent.showLightbox = true
            print("requestlightbox")
        }
        
        func galleryControllerDidCancel(_ controller: GalleryController) {
            print("cancel")
        }
        
        
    }
    
    
    
    //typealias UIViewControllerType = GalleryController
    
    

    
    
    
    
}

