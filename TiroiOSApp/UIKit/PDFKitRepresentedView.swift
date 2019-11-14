//
//  PDFKitRepresentedView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI
import PDFKit

struct PDFKitRepresentedView: UIViewRepresentable {
    var pdfDoc: PDFDocument
    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDoc
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        uiView.document = pdfDoc
    }
    
    typealias UIViewType = PDFView
    
//    let pdfDoc: PDFDocument
//
//    init(_ pdfDoc: PDFDocument) {
//        self.pdfDoc = pdfDoc
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
//        // Create a `PDFView` and set its `PDFDocument`.
//        let pdfView = PDFView()
//        pdfView.document = pdfDoc
//        return pdfView
//    }
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
//        // Update the view.
//    }
}
