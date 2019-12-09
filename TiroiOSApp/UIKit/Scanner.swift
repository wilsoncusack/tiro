//
//  Scanner.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

import Vision
import VisionKit
import PDFKit

final class TextRecognizer {
    let cameraScan: VNDocumentCameraScan
    
    init(cameraScan: VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    
    private let queue = DispatchQueue(label: "com.augmentedcode.scan", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    
    func recognizeText(withCompletionHandler completionHandler: @escaping ([String]) -> Void) {
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({ self.cameraScan.imageOfPage(at: $0).cgImage })
            let imagesAndRequests = images.map({ (image: $0, request: VNRecognizeTextRequest()) })
            let textPerPage = imagesAndRequests.map { image, request -> String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do {
                    try handler.perform([request])
                    guard let observations = request.results as? [VNRecognizedTextObservation] else { return "" }
                    return observations.compactMap({ $0.topCandidates(1).first?.string }).joined(separator: "\n")
                }
                catch {
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var showModal: Bool
    @Binding var pdfDocument: PDFDocument
     //@Binding var imageArray: [UIImage]
//    private let completionHandler: ([UIImage]?) -> Void
    
//    init(showModal: Bool, completion: @escaping ([UIImage]?) -> Void) {
//        self.showModal = showModal
//        self.completionHandler = completion
//    }
    
    typealias UIViewControllerType = VNDocumentCameraViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {}
    
    func makeCoordinator() -> Coordinator {
        //return Coordinator(completion: completionHandler)
        return Coordinator(showModal: $showModal, pdfDocument: $pdfDocument)
    }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        //private let completionHandler: ([UIImage]?) -> Void
        
//        init(completion: @escaping ([UIImage]?) -> Void) {
//            self.completionHandler = completion
//        }
        var showModal: Binding<Bool>
//        var imageArray: Binding<[UIImage]>
        var pdfDocument: Binding<PDFDocument>
        
        init(showModal: Binding<Bool>, pdfDocument: Binding<PDFDocument>){
            self.showModal = showModal
//            self.imageArray = imageArray
            self.pdfDocument = pdfDocument
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            let recognizer = TextRecognizer(cameraScan: scan)
            //var imgArray = [UIImage]()
            let pdfDocument = PDFDocument()
            for i in 0 ..< scan.pageCount{
                //imgArray.append(scan.imageOfPage(at: i))
                let pdfPage = PDFPage(image: scan.imageOfPage(at: i))
                pdfDocument.insert(pdfPage!, at: i)
                
            }
           // completionHandler(imgArray)
            //imageArray.wrappedValue = imgArray
            self.pdfDocument.wrappedValue = pdfDocument
            showModal.wrappedValue = false
            //recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            //completionHandler(nil)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            //completionHandler(nil)
        }
    }
}
