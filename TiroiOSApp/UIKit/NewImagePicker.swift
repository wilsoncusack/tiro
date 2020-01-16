//
//  NewImagePicker.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/5/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import UIKit
import SwiftUI
import Photos


struct NewImagePickerViewController: UIViewControllerRepresentable {
    @Binding var image: Data?
    
    

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<NewImagePickerViewController>) {
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NewImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        

        //I had the same the issue, first check permissions and request access:

        let status = PHPhotoLibrary.authorizationStatus()

        if status == .notDetermined  {
            PHPhotoLibrary.requestAuthorization({status in

            })
        }
        
        return imagePicker
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        var parent: NewImagePickerViewController

        init(_ parent: NewImagePickerViewController) {
            self.parent = parent
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[.editedImage] as! UIImage
            parent.image = imagePicked.jpegData(compressionQuality: 1)!


            picker.dismiss(animated: true, completion: nil)
        }
    }
}
