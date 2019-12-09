//
//  NewValueTest.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/19/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

// value, action
// can this conform to that generic type?
// need to catch up on videos tomorrow


// if image,
// render display view for that image

struct ImagesDocumentRowView: View{
    @ObservedObject var document: DocumentLoadable
   // @State var element: ElementWrapper? = nil
    
    init(document: DocumentLoadable){
        self.document = document
        //self.document.load()
    }
    
    
    var imagesElement: ElementLoadable?{
         getFirstElementOfType(elements: document.elementWrappers, type: .images, load: false)
//        for e in document.elementWrappers{
//            if case .images = e.element.type {
//                    return e
//            }
//
//        }
//        return nil
    }
    
    var captionElement: ElementLoadable?{
         getFirstElementOfType(elements: document.elementWrappers, type: .string, load: true)
//        for e in document.elementWrappers{
//            if case .string = e.element.type {
//                e.loadSync()
//                    return e
//            }
//
//        }
//        return nil
    }
    
    
    var body: some View{
        
        if(imagesElement != nil){
            return AnyView(
                VStack(alignment: .leading){
                ElementRowView(element: imagesElement!)
                    //if(captionElement?.value != nil){
                    ElementRowView(element: captionElement!)
                    
                    // }
                }
            )
        } else {
           return AnyView(EmptyView())
        }
    }
}



//extension Value {
//    var displayView: DisplayView{
//        return DisplayView(value: self)
//    }
//}

//struct NewGenericDisplayView: View {
//
//}

struct DisplayView: View {
    var widthOffset: CGFloat
    var value: Value
    
    var body: some View{
        switch value{
            
        case .string(let value, let displayType, let editType):
            return AnyView(Text(value).padding(.all, 15))
            return AnyView(EmptyView())
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return getPickerDisplay(pickerStruct: value, displayType: displayType, editType: editType)
        case .documentValue(let value, let displayType, let editType):
            var documentLoadable = DocumentLoadable(document: value.document)
            return AnyView(
                DocumentLoadableRowView(doc: documentLoadable))
                //DocumentLoadable(document: value.document).RowView)
        case .images(let value, let displayType, let createType, let editType):
            return AnyView(
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        ForEach(value.map {$0.uiImage}, id: \.self){i in
                            Image(uiImage: i)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                           // .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width - self.widthOffset)
                            //.scaledToFit()
                        }
                    }
            })
        case .pdf(let value, let displayType, let createType, let editType):
            return AnyView(EmptyView())
        }
    }
}





//class NewValueTestObj: ObservableObject{
//    @ObservedObject var documentElement: Document_Element
//    @Published var value: Value? = nil
//
//    init(documentElement: Document_Element){
//        self.documentElement = documentElement
//        //self.value = documentElement.value
//    }
//
//    func loadValue(){
//        self.value = documentElement.value
//    }
//}

//struct NewValueTest: View {
//    @ObservedObject var obj: NewValueTestObj
//    var body: some View {
//        VStack{
//            if(obj.value == nil){
//                Text("loading")
//            } else {
//                // Text("done loading")
//                obj.documentElement.displayView
//                // .frame(height: 400)
//            }
//        }
//        .onAppear(){
//            self.obj.loadValue()
//        }
//    }
//}

//struct NewValueTest_Previews: PreviewProvider {
//    static var previews: some View {
//        NewValueTest()
//    }
//}
