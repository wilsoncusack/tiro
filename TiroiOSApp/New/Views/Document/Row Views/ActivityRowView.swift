//
//  ActivityRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/8/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ActivityRowView: View {
    @ObservedObject var documentLoadable: DocumentLoadable
    
    var images: [UIImage]{
        var imageElements = documentLoadable
        .elementWrappers
            .filter {
                $0.element.type == .images
            }
        if(imageElements.count > 0){
            let imageElement = imageElements[0]
        imageElement.loadSync()
        if case .images(let value, let displayType, let createType, let editType) = imageElement.value! {
            return value.map {$0.uiImage}
        }
        }
    return []
    }
    
    var text: String {
        var strs = documentLoadable
            .elementWrappers
                .filter {
                    $0.element.type == .string
                }
            if(strs.count > 0){
                let str = strs[0]
            str.loadSync()
            if case .string(let value, let displayType, let editType) = str.value! {
                return value.string
            }
        }
        return ""
    }
    
    var body: some View {
        if(images.count != 0){
            return AnyView(Image(uiImage: images[0])
            .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 115, height: 215)
               .cornerRadius(8)
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                .padding()
                .shadow(radius: 25)
                
                , alignment: .bottomLeading
            ))
        } else {
            return AnyView(HStack{
                                    
                                    Text(text)
            //                            .fontWeight(.semibold)
                                        .font(.subheadline)
                                    .padding()
                                        

                                    
                                       // .fontWeight(.bold)
                                    Spacer()
                                }.overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondary, lineWidth: 0.4)))
                            
                        
        }
    }
}

//struct ActivityRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityRowView()
//    }
//}
