//
//  GalleryCreate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/11/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Foundation
import Photos
import Gallery
import YPImagePicker
import Combine

//func get(item: YPMediaItem) -> UIImage{
//    switch item{
//
//    case .photo(let p):
//       return  p.image
//    case .video(let v):
//        return v.thumbnail
//    }
//}

func getImageFromData(data: Data) -> UIImage{
    var x = UIImage(data: data)
    if(x == nil){
        print("image is nil")
    }
    return x!
}

class ImagePickerObject: ObservableObject {
    @Published var images: [Data]
    var listener : AnyCancellable?
    
    init(images: [Data]){
        self.images = images
        self.listener = self.$images.sink { (data) in
            print("received value")
        }
    }
    
    deinit {
        print("cancelling")
        listener!.cancel()
    }
}

struct MyValueParams<Value, DisplayType, CreateType, EditType>: Codable where Value: Codable, DisplayType: Codable, CreateType: Codable, EditType: Codable{
    let value: Value
    let displayType: DisplayType
    let createType: CreateType?
    let editType: EditType
    
    init(value: Value, displayType: DisplayType, createType: CreateType? = nil, editType: EditType) {
        self.value = value
        self.displayType = displayType
        self.createType = createType
        self.editType = editType
    }
}

struct YPCreate: View {
    //@ObservedObject var el: Document_Element
    @ObservedObject var obj: ImagePickerObject
   // @State var items = [YPMediaItem]()
    @State var showModal: Bool
    
//    var value: Value {
//        Value.dataArray(value: obj.images, displayType: .images, createType: .photoLibrary, editType: .images)
//    }
    
//    var images: [UIImage] {
//           var toReturn = [UIImage]()
//
//               if case .dataArray(let value, let displayType, let createType, let editType) = value {
//               switch displayType{
//
//               case .images:
//                   print("returning value map images")
//                   print("length: \(value.count)")
//                   for d in value{
//                       toReturn.append(getImageFromData(data: d))
//                   }
//                   //return value.map {getImageFromData(data: $0)}
//
//
//               }
//           }
//
//           return toReturn
//       }
    
//    var valueParams: MyValueParams<[Data], DataArrayDisplayType, DataCreateDisplayType, DataArrayEditDisplayType>{
//        MyValueParams<[Data], DataArrayDisplayType, DataCreateDisplayType, DataArrayEditDisplayType>(value: images.map {$0.pngData()!}, displayType: DataArrayDisplayType.images, editType: DataArrayEditDisplayType.images)
//    }
//
//    var element: Document_Element{
//
//        return Document_Element(order: 0, value: value, document: el.document)
//    }
//
//    var final: MyValueParams<[Data], DataArrayDisplayType, DataCreateDisplayType, DataArrayEditDisplayType>? {
//        var encoder = JSONEncoder.init()
//        do{
//        let x = try encoder.encode(valueParams)
//            let k = try JSONDecoder().decode(MyValueParams<[Data], DataArrayDisplayType, DataCreateDisplayType, DataArrayEditDisplayType>.self, from:  x)
//            return k
//        } catch {
//            print("error")
//        }
//        return nil
//    }
//
//    var final_from_el: [UIImage] {
//        var toReturn = [UIImage]()
//
//        if case .dataArray(let value, let displayType, let createType, let editType) = element.value {
//                switch displayType{
//
//                case .images:
//                    print("returning value map images")
//                    print("length: \(value.count)")
//                    for d in value{
//                        toReturn.append(getImageFromData(data: d))
//                    }
//                    //return value.map {getImageFromData(data: $0)}
//
//
//                }
//            }
//
//            return toReturn
//    }
    
    
    
   
    var body: some View {
       // Section{
        VStack{
            //ScrollView(.horizontal, showsIndicators: false){
//            if(final != nil){
//                HStack(spacing: 10){
//                    ForEach(final_from_el, id: \.self){i in
//                        Image(uiImage: i).resizable().scaledToFit()
//                    }}
//            }
            //}
           // Form{
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10){
                    ForEach(obj.images.map {getImageFromData(data: $0)}, id: \.self){i in
                Image(uiImage: i).resizable().scaledToFit()
            }
                }
            }.frame(height: 200)
               // }
           // }
        }.sheet(isPresented: $showModal){
            YPRepresentable(items: self.$obj.images)
            //YPRepresentable(items: self.$items)
                
            
        }
        .onDisappear(){
            print("disappear")
            self.obj.listener!.cancel()
        }
    }
        
}

func getAssetThumbnail(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: CGSize(width: 200, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        thumbnail = result!
    })
    return thumbnail
}

struct GalleryCreate: View {
    @State var showGallery = true
    @State var showLightbox = false
    @State var images = [Gallery.Image]()
    
    var uiImages: [UIImage]{
        var a = [UIImage]()
        for i in images{
            a.append(getAssetThumbnail(asset: i.asset))
        }
        return a
    }
    var body: some View {
        VStack{
            if(showLightbox){
                Button(action: {self.showLightbox = false}){
                    Text("Back to photos")
                }
                ScrollView(.horizontal, showsIndicators: false){
                HStack{
                ForEach(uiImages, id: \.self){i in
                    Image(uiImage: i)
                }
                    }
                }
            } else if(showGallery){
                VStack{
                GalleryPicker(showGallery: $showGallery, showLightbox: $showLightbox, images: $images)
            .frame(height: UIScreen.main.bounds.height - 88)
                    .overlay(
                        Text("Take up to 10 pictures")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        .padding()
                            .background(Color.black.opacity(0.8))
                        .cornerRadius(8)
                            .padding(.top, 50)
                        , alignment: .top)
                }.frame(height: UIScreen.main.bounds.height)
                .background(Color.black)
            }
            
        }
            

    }
}

//struct GalleryCreate_Previews: PreviewProvider {
//    static var previews: some View {
//        //GalleryCreate()
//        YPRepresentable()
//    }
//}
