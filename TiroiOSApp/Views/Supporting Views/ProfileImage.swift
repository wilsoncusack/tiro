//
//  ProfileImage.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct ProfileImage : View {
    var imageName : String
    var size : CGFloat
    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

#if DEBUG
struct ProfileImage_Previews : PreviewProvider {
    static var previews: some View {
        ProfileImage(imageName : "rabbit", size: 100)
    }
}
#endif
