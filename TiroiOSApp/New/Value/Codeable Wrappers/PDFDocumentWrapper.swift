//
//  PDFDocumentWrapper.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import PDFKit

class PDFDocumentWrapper: Codable{
private enum CodingKeys: String, CodingKey{
    case pdfDocumentData
}
let pdfDocument: PDFDocument
    
    init(data: Data){
         pdfDocument = PDFDocument(data: data)!
        
    }
    
    init(){
        pdfDocument = PDFDocument()
    }

func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.pdfDocument.dataRepresentation()!, forKey: .pdfDocumentData)
}

required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    if let data : Data = try container.decodeIfPresent(Data.self, forKey: .pdfDocumentData)
    {
        if let document : PDFDocument = PDFDocument(data: data){
            self.pdfDocument = document
        } else {
            print("this error")
            throw SDKError.pdfConversionError
        }
    } else {
        print("that error")
        throw SDKError.pdfConversionError
    }

}
}
