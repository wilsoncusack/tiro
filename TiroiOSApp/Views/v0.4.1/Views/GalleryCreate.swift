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

func get(item: YPMediaItem) -> UIImage{
    switch item{
        
    case .photo(let p):
       return  p.image
    case .video(let v):
        return v.thumbnail
    }
}

struct YPCreate: View {
    @State var items = [YPMediaItem]()
    @State var showModal = true
    var body: some View {
        VStack{
            Form{
                Section{
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 10){
            ForEach(items.map {get(item: $0)}, id: \.self){i in
                Image(uiImage: i).resizable().scaledToFit()
            }
                }
            }.frame(height: 200)
                }
                Text("caption")
            }
        }.sheet(isPresented: $showModal){
            YPRepresentable(items: self.$items)
            
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
