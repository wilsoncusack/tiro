//
//  DisplayUIImage.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/22/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct DisplayUIImage: View {
    var uiImageData : Data
    var image : UIImage {
        UIImage(data: uiImageData)!
    }
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .rotationEffect(image.imageOrientation == UIImage.Orientation.right ? .degrees(90) : .degrees(0))
         //.rotationEffect(.degrees(90))
    }
}

#if DEBUG
//struct DisplayUIImage_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayUIImage()
//    }
//}
#endif
