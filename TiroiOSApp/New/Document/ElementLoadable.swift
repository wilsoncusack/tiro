//
//  ElementLoadable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

class ElementLoadable: ObservableObject{
    var element: Document_Element
    @Published var value: Value? = nil
    
    init(element: Document_Element){
        self.element = element
    }
    
    func loadAsync(){
            DispatchQueue.main.async {
                    self.value = self.element.decodeValue()
        }
    }
    
    func loadSync(){
            self.value = self.element.decodeValue()
    }
    
}



struct GenericImagesView: View{
    var images: [UIImage]
    var displayType: ImagesDisplayType
    var frameWidth: CGFloat
    
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
        HStack(spacing: 10){
            ForEach(images, id: \.self){i in
                Image(uiImage: i)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.frameWidth)
            }
        }
    }
}
}
