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
//            let imageURL = info[.imageURL] as! NSURL
//            let imageName = imageURL.lastPathComponent!
//            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as! String
////            let localPath = documentDirectory.appendingPathComponent(imageName)
//            print(imageName)
//            print(documentDirectory)
//            print(imageURL.absoluteString)

//            let image = info[.originalImage] as! UIImage
//            let data = image.pngData()
//            data.writeToFile(localPath, atomically: true)
//
//            let imageData = NSData(contentsOfFile: localPath)!
//            let photoURL = NSURL(fileURLWithPath: localPath)
//            let imageWithData = UIImage(data: imageData)!
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
