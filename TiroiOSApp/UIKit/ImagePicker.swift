//
//  ImagePicker.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/18/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var uiImage : UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
//        @Binding var isShown: Bool
//        @Binding var image: Image?
//        @Binding var uiImage : UIImage?
        var imagePicker : ImagePicker
        
//        init(isShown: Binding<Bool>, image: Binding<Image?>, uiImage: Binding<UIImage?>) {
//            super.init()
////            self.$isShown = isShown
////            self.$image = image
////            self.$uiImage = uiImage
//        }
        init(_ imagePicker : ImagePicker){
            self.imagePicker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            imagePicker.uiImage =  (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
//            print("called")
            imagePicker.image = Image(uiImage: imagePicker.uiImage!)
//            if(uiImage!.imageOrientation == UIImage.Orientation.right){
//                print(uiImage!.imageOrientation)
//                image = image!.rotationEffect(.degrees(90.0))
//            }else {
//                print("baddd!!!!")
//            }
        
            //image = Image(uiImage: uiImage!)
            
            imagePicker.isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

            imagePicker.isShown = false
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
//        return Coordinator(isShown: $isShown, image: $image, uiImage: $uiImage)
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}
