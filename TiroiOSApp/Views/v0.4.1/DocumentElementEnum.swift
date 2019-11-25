////
////  DocumentElementEnum.swift
////  TiroiOSApp
////
////  Created by Wilson Cusack on 11/7/19.
////  Copyright © 2019 Wilson Cusack. All rights reserved.
////
//
import Foundation
import SwiftUI

enum ValueOptions: Int, CaseIterable, Identifiable {
    var id: Int {
        return self.rawValue
    }
    
    case text
    case camera
    case photos
    //case video
    case quote
    case scan
    case question
    case reading
    
    var title: String {
        switch self {
        case .text: return "text"
        case .camera: return "camera"
        //        case .video: return "video"
        case .photos: return "photos"
        case .quote: return "quote"
        case .scan: return "scan"
        case .question: return "question"
        case .reading: return "reading"
            
        }
    }
    
    var image: String {
        switch self {
        case .text: return "textformat"
        case .camera: return "camera"
        case .photos: return "photo.on.rectangle"
        //        case .video: return "video"
        case .quote: return "quote.bubble"
        case .scan: return "viewfinder"
            
        case .question: return "questionmark.circle"
        case .reading: return "book"
            
        }
    }
    
    // wait ok
    // so first we need to get today
    // then we need to get an editable version
    // then
    // we really, when we save this thing,
    // we need to make sure we save it to an editable version of today
    
    func getCreateView(user: User, today: Document) -> AnyView {
        switch self {
        case .text:
            var template = getTemplate(name: "Text", type: .text)
            
            return template.getEditableVersion(user: user).getEditView()
        case .camera:
            return AnyView(GalleryCreate())
        case .photos:
            return AnyView(EmptyView())
            //        case .video:
        //            return AnyView(YPCreate())
        case .quote:
            return AnyView(TextCreate())
        case .scan:
            return AnyView(ScanCreate())
            
        case .question:
            return AnyView(TextCreate())
        case .reading:
            return AnyView(TextCreate())
        }
    }
    var template: Document {
        switch self {
        case .text:
            return getTemplate(name: "Text", type: .text)
           // return template
            
           // return template.getEditableVersion().getEditView()
        case .camera:
             return getTemplate(name: "Text", type: .text)
        case .photos:
             return getTemplate(name: "Image", type: .image)
            //        case .video:
        //            return AnyView(YPCreate())
        case .quote:
            return getTemplate(name: "Text", type: .text)
        case .scan:
            return getTemplate(name: "Text", type: .text)
            
        case .question:
           return getTemplate(name: "Text", type: .text)
        case .reading:
            return getTemplate(name: "Text", type: .text)
        }
    }
}
//
// just make it work and get it out
// we can work on it more when we get help

//// it does feel kind of unnecessary to have to do this at every step
//// maybe we should have a display type





//extension Document_Element{
//    func getDisplayView() -> AnyView {
//        AnyView(EmptyView())
//    }
//}





// ok but how do we create the editable version
// in the case they want to throw it away?
// I suppose we could just create and then delete?
// That seems easier than maintaining a whole different
// set of data objects in memory as document templates
// yeah because eventually they'll want to create their own templates
// but ok let me think: if given a template, we could create a
// transient document
// need to keep track of things like order
// so yeah, given a template, we could copy all of the types

///
/// so maybe a template flag
/// not edit the template
// yeah I think that works great
//




// maybe we want like an in memory value type?

enum ValueTranscient {
    case string(String)
    case int(Int)
    case double(Double)
    case image(Data)
    case document(coreDataDocument: Document, title: String, tags: [Tag], associated_users: [User], date: Date, elements: [ValueTranscient])
    case date(Date)
    //case picker(Picker)
    

    
//    mutating func getEditable() -> AnyView {
//        switch self{
//
//
//        case .string(_):
//            <#code#>
//        case .double(_):
//            <#code#>
//        case .image(let data):
//            return AnyView(
//                imageView(image: data, onChange: {d in
//                    self = .image(data)
//                }
//                    )
//            )
//
//        case .document(let id, let title, let tags, let associated_users, let date, let elements):
//            <#code#>
//        case .date(_):
//            <#code#>
//        case .picker(_):
//            <#code#>
//        }
//    }
//
    func updateCoreData(){
        
    }
}

struct imageView: View {
    @State var image: Data
    var onChange: (Data) -> Void
    
    var body: some View{
        EmptyView()
    }
}

// for each
// get editable
// on edit, update the temp value -> think on how to do that
// on save, move through whole group and update
// ok yeah but that assumes edit works
// so lets thing about that

// this is very very good

// could just add a new document type up above
// that's really the only difference between the types
// one document has a core data ID
// one has all the stuff
// something to think about
