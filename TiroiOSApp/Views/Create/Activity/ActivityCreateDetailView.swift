//
//  ActivityCreateDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityCreateDetailView : View {
    @State var title = ""
   @State var notes = ""
    @State var activityDate = Date()
     @State var showImagePicker: Bool = false
    @State var image : Image?
    @State var uiImage : UIImage?
    
//    @State var participants : [Learner] = []
//    @State var image_name = ""
//
//
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .full
//        return formatter
//    }
//
    
    var body: some View {
        VStack{
        if (showImagePicker) {
            ImagePicker(isShown: $showImagePicker, image: $image, uiImage: $uiImage)
        } else {
        Form{
            TextField("Title", text: $title)
            TextField("Notes",  text: $notes)
                .frame(width: 150, height: 150)
                .lineLimit(nil)
            DatePicker("Date", selection: $activityDate)
//            DatePicker($activityDate, maximumDate: Date(), displayedComponents: .date, label: {Text("Date")})
            Section(header : Text("Pick Image")){
                if (image == nil) {
                    Button(action: {
                        withAnimation {
                            self.showImagePicker = true
                        }
                    }) {
                        Text("Add Photo")
                    }
                }
                
                if (image != nil) {
                    image?
                        .resizable()
                            //.rotationEffect(uiImage?.imageOrientation == UIImage.Orientation.right ? .degrees(90) : .degrees(0))
                        .frame(width: 100 , height: 100)
                        .aspectRatio(contentMode: .fit)
                    
                }
            }
        }
        }
        }
        .navigationBarTitle("Create Activity", displayMode: .inline)
    }
}

#if DEBUG
struct ActivityCreateDetailView_Previews : PreviewProvider {
    static var previews: some View {
        ActivityCreateDetailView()
    }
}
#endif
