//
//  ImagePicker.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/18/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import UIKit
import SwiftUI


struct ImagePickerViewController: UIViewControllerRepresentable {
    @Binding var showModal: Bool
    @Binding var image: UIImage?
    

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerViewController>) {
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        var parent: ImagePickerViewController

        init(_ parent: ImagePickerViewController) {
            self.parent = parent
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[.editedImage] as! UIImage
            parent.image = imagePicked
            parent.showModal = false


            picker.dismiss(animated: true, completion: nil)
        }
    }
}

//extension ImagePickerViewController: RSKImageCropViewControllerDelegate {
//
//    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
//        _ = self.navigationController?.popViewController(animated: true)
//    }
//
//    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
//        self.avatarImageView.image = croppedImage
//        _ = self.navigationController?.popViewController(animated: true)
//    }
//
//}
