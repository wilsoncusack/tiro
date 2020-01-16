//
//  ImagePickerCreate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/18/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine
//
//class ImagePickerObject2: ObservableObject {
//    @ObservedObject var tEl: TransientDocumentElement
//    @Published var images: [ImageWrapper]
//    var listener : AnyCancellable?
//
//    init(tEl: TransientDocumentElement, images: [ImageWrapper]){
//        self.tEl = tEl
//        self.images = images
//        self.listener = self.$images.sink { (arr) in
//            //print("received value")
//            tEl.value = Value.images(value: arr, displayType: ImagesDisplayType.images, createType: ImagesCreateDisplayType.photoLibrary, editType: ImagesEditDisplayType.images)
//        }
//    }
//
//    deinit {
//        print("cancelling")
//        listener!.cancel()
//    }
//}

struct EditImageObject: Equatable {
    static func == (lhs: EditImageObject, rhs: EditImageObject) -> Bool {
        lhs.images == rhs.images && lhs.date == rhs.date
    }
    
    var images: [ImageWrapper]
    var date: Date
}


struct YPCreate2: View {
    @ObservedObject var obj: ObservableValue<EditImageObject>
    @State var showModal: Bool
    

    
   
    var body: some View {
        VStack(alignment: .leading){
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10){
                    ForEach(obj.value.images.map {$0.uiImage}, id: \.self){i in
                Image(uiImage: i).resizable().scaledToFit()
            }
                }
            }.frame(height: obj.value.images.count == 0 ? 5 : 150)
            if(!showModal){
                Button(action: {self.showModal = true}){
                    Text(obj.value.images.count == 0 ? "Add Photos" : "Change Photos")
                }
            }
        }.sheet(isPresented: $showModal){
            YPRepresentable2(items: self.$obj.value.images, imageDate: self.$obj.value.date)
        }
//        .onDisappear(){
//            print("disappear")
//            self.obj.listener?.cancel()
//        }
    
    }
        
}
