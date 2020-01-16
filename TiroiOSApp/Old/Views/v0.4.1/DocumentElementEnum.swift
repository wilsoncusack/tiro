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
import CoreData

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
            return getTemplate(name: "Quote", type: .quote)
        case .scan:
            return getTemplate(name: "Scan", type: .scan)
            
        case .question:
           return getTemplate(name: "Text", type: .text)
        case .reading:
            return getTemplate(name: "Text", type: .text)
        }
    }
}


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

var orangeMedium = Color(red: 0.9921568627, green: 0.9490196078, blue: 0.8274509804)

func getTemplate(name: String, type: DocumentType) -> Document {
    let templateFetch = NSFetchRequest<Document>(entityName: "Document")
    let p1 = NSPredicate(format: "is_template == true")
    let p2 = NSPredicate(format: "type_private == %@", type.rawValue)
    templateFetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1, p2])
    do {
        let fetchedTemplates = try AppDelegate.viewContext.fetch(templateFetch)
        return fetchedTemplates[0]
    } catch {
        fatalError("Failed to fetch users: \(error)")
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
