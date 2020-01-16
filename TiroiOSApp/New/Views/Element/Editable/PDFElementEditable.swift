//
//  PDFElementEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFElementEditable: View {
    @ObservedObject var observedPDF: ObservableValue<PDFDocument>
    @State var showModal = false
    
    init(value: PDFDocumentWrapper, displayType: PDFDisplayType, createType: PDFCreateDisplayType, editType: PDFEditDisplayType, element: DocumentElementEditable){
        self.observedPDF = ObservableValue<PDFDocument>(value: value.pdfDocument){
        pdfDocument in
            print("save function called")
            element.localValue = Value.pdf(value: PDFDocumentWrapper(data: pdfDocument.dataRepresentation()!), displayType: displayType, createType: createType, editType: editType)
        }
    }
    
    var body: some View {
        VStack{
                   // Text("pages: \(doc.pageCount)")
            PDFKitRepresentedView(pdfDoc: observedPDF.value)
                        .frame(width: 200, height: 300)
            
                Button(action: {self.showModal = true}){
                    Text("Make Scan")
                }
                }.sheet(isPresented: $showModal){
                    ScannerView(showModal: self.$showModal, pdfDocument:  self.$observedPDF.value)
                    
        }.onDisappear(){
            print("cancelling scan object in view")
            //self.observedPDF.listener!.cancel()
        }
    }
}

//struct PDFElementEditable_Previews: PreviewProvider {
//    static var previews: some View {
//        PDFElementEditable()
//    }
//}
