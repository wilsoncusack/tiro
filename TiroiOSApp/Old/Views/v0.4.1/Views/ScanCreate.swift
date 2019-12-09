//
//  ScanCreate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import PDFKit
import Combine

class ScanObject<AValue>: ObservableObject{
    @ObservedObject var transientElement: TransientDocumentElement
    @Published var aValue: AValue
    //var saveFunction: (AValue) -> Void
    var listener : AnyCancellable?
    
    init(tEl: TransientDocumentElement, aValue: AValue, saveFunction: @escaping (AValue) -> Void){
        self.transientElement = tEl
        self.aValue = aValue
            //self.saveFunction = saveFunction
        self.listener = self.$aValue.sink { (v) in
          saveFunction(v)
        }
    }
    
    deinit {
        print("cancelling scan object")
        listener!.cancel()
    }
}

struct ScanEdit: View {
    @ObservedObject var scanObj: ScanObject<PDFDocument>
    @State var showModal = false
    
    var body: some View{
        VStack{
                   // Text("pages: \(doc.pageCount)")
            PDFKitRepresentedView(pdfDoc: scanObj.aValue)
                        .frame(width: 200, height: 300)
            
                Button(action: {self.showModal = true}){
                    Text("Show")
                }
                }.sheet(isPresented: $showModal){
                    ScannerView(showModal: self.$showModal, pdfDocument:  self.$scanObj.aValue)
                    
        }.onDisappear(){
            print("cancelling scan object in view")
            self.scanObj.listener!.cancel()
        }
    }
}

//struct ScanCreate: View {
//    @State var showModal = false
//    @State var imageArray = [UIImage]()
//
//    var doc: PDFDocument {
//        let pdfDocument = PDFDocument()
//        for i in 0 ..< imageArray.count {
//            let pdfPage = PDFPage(image: imageArray[i])
//            pdfDocument.insert(pdfPage!, at: i)
//
//        }
//        return pdfDocument
//    }
//    var body: some View {
//        VStack{
//            Text("pages: \(doc.pageCount)")
//            PDFKitRepresentedView(pdfDoc: doc)
//                .frame(width: 200, height: 300)
//        Button(action: {self.showModal = true}){
//            Text("Show")
//        }
//        }.sheet(isPresented: $showModal){
////            ScannerView { (strArr) in
////                if(strArr != nil){
////                    print(strArr![0])
////                }
////            }
//            ScannerView(showModal: self.$showModal, imageArray: self.$imageArray)
//
//        }
//    }
//}
//
//struct ScanCreate_Previews: PreviewProvider {
//    static var previews: some View {
//        ScanCreate()
//    }
//}
