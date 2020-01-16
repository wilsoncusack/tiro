//
//  CreationRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct CreationRowView : View {
    var title : String
    var description : String
    var image : Image
    var body: some View {
        HStack{
            image.resizable().frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 22))
                    .bold()
                Text(description)
                    .font(.subheadline)
            }.padding(.leading, 20)
        }.frame(height: 80)
    }
}

#if DEBUG
struct CreationRowView_Previews : PreviewProvider {
    static var previews: some View {
        CreationRowView(title : "Question", description: "Record a question to answer later", image: Image(systemName: "questionmark.circle"))
    }
}
#endif
