//
//  ActivityCreateDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct ImagePicker : View {
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePickerViewController(image: $image)
    }
}



struct ActivityEditableForm : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    var activity : Activity?
    @ObjectBinding var activityBindable : ActivityBindable
    
    @State var image : UIImage? = nil
    
    
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
            return formatter
        }()
    
    func save() {
            // might be interesting to try handling this in the deinit of the bindable object, but
            // then you'd have to create activity in init and delete if cancelled
            // another idea is to have tthe dinbale activity always be alive inside the NSObject
        if(image != nil){
            activityBindable.image = image!.jpegData(compressionQuality: 1)
        }
        if activity != nil {
            mainEnv.saveActivityFromBindable(bindableActivity: activityBindable, activity: activity!)
        } else {
            mainEnv.createActivtyFromBindable(bindable: activityBindable)
        }
            
            
        }
    
    var body : some View {
        Form{
            Section(header: Text("Title")){
                TextField("Activity on " + Self.dateFormatter.string(from: activityBindable.activityDate), text: $activityBindable.title)
            }
            TextField("Notes",  text: $activityBindable.notes)
                .lineLimit(nil)
            DatePicker("Date", selection: $activityBindable.activityDate)
            Section(header : Text("Pick Image")){
                if(activityBindable.image != nil){
                    HStack{
                    DisplayUIImage(uiImageData: activityBindable.image!)
                        .aspectRatio(contentMode: .fit)
                       .frame(height: 100)
                    PresentationLink(destination: ImagePicker(image: $image), label: {
                                                Text("Change Photo")
                                            }).padding(.leading, 15)
                    }
                } else if(image != nil) {
                    HStack{
                        DisplayUIImage(uiImageData: image!.jpegData(compressionQuality: 1)!)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)


                        PresentationLink(destination: ImagePicker(image: $image), label: {
                            Text("Change Photo")
                        }).padding(.leading, 15)
                    }
                }
                else {
                    PresentationLink(destination: ImagePicker(image: $image), label: {
                        Text("Add Photo")
                    })
                }
            }
            
        }
        .navigationBarItems( trailing:

                            Button(action: {
                               self.save()
                                self.showModal = false
                            }){
                                Text("Save")
                            }
                    )
    }
}

struct ActivityCreateDetailView : View {
    @EnvironmentObject var mainEnv : MainEnvObj
    @Binding var showModal : Bool
    var activity : Activity?
    
    var activityBindable : ActivityBindable {
        if activity != nil {
            return mainEnv.createBindablefromActivity(activity: activity!)
        } else {
            return ActivityBindable(title: "", notes: "", activityDate: Date(), image: nil, participants: [])
        }
    }
    
    
    
    
    
    var body: some View {
        
            ActivityEditableForm(showModal: $showModal, activity: activity, activityBindable: activityBindable)
                .navigationBarTitle("\(activity != nil ? "Edit" : "Create") Activity", displayMode: .inline)
        
            
    }
}

#if DEBUG
struct ActivityCreateDetailView_Previews : PreviewProvider {
    @State static var showModal = false
    static var previews: some View {
        ActivityCreateDetailView(showModal: $showModal).environmentObject(MainEnvObj())
    }
}
#endif
