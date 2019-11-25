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

class DocumentWrapper2: ObservableObject{
    @ObservedObject var document: Document
    @Published var elementWrappers: [ElementWrapper] = []
    //  @Published var values: [Value] = []
    
    init(document: Document){
        self.document = document
    }
    
    // maybe should store the elements up here
    // so that can can compare when it's done loading
    
    func load(){
        DispatchQueue.main.async {
            var elements = self.document.elements?.allObjects as! [Document_Element]
            // sort them some how
            for element in elements{
                self.elementWrappers.append(ElementWrapper(element: element))
            }
        }
    }
    
    var RowView: some View{
        
        switch self.document.type{
        case .book:
            return AnyView(EmptyView())
        case .event:
            return AnyView(EmptyView())
        case .activity:
            return AnyView(EmptyView())
        case .day:
            return AnyView(EmptyView())
        case .text:
            //            var elements = self.elements?.allObjects as! [Document_Element]
            return AnyView(TextViewDay(document: self.document))
        case .quote:
            return AnyView(EmptyView())
        case .image:
            print("returning image row view")
            return AnyView(
                ImagesDocumentRowView(document: self)
                //NewImageDayView(document: self.document)
            )
        //AnyView(ImageDayView(document: self))
        case .scan:
            return AnyView(EmptyView())
        case .video:
            return AnyView(EmptyView())
        case .question:
            return AnyView(EmptyView())
        case .reflection:
            return AnyView(EmptyView())
        case .camera:
            return AnyView(EmptyView())
        }
        
    }
    
    var DetailView: AnyView{
        switch self.document.type{
        case .day:
            return AnyView(GenericDay2(document: self))
        default:
            return AnyView(GenericDetailView2(doc: self))
        }
        
    }
    
    //    var EditView: AnyView{
    //        return self.document.getEditableVersion(user: <#T##User#>)
    //    }
}
// if image,
// render display view for that image

struct ImagesDocumentRowView: View{
    @ObservedObject var document: DocumentWrapper2
   // @State var element: ElementWrapper? = nil
    
    init(document: DocumentWrapper2){
        self.document = document
        //self.document.load()
    }
    
    var images: [UIImage]{
        var toReturn = [UIImage]()
        for e in document.elementWrappers{
            // would be nice to find type without having to load
            if case .images(let value, let displayType, let createType, let editType) = e.element.value! {
                switch displayType{
                    
                case .images:
                    toReturn  = value.map {$0.uiImage}
                    
                    
                }
            }
            
        }
        return toReturn
        
    }
    
    var imagesElement: ElementWrapper?{
        for e in document.elementWrappers{
            // would be nice to find type without having to load
            if case .images(let value, let displayType, let createType, let editType) = e.element.value! {
                //switch displayType{
                    return e
//                case .images:
//                    toReturn  = value.map {$0.uiImage}
                    
                    
                //}
            }
            
        }
        return nil
    }
    
    
    var body: some View{
        // maybe put in an if in here if the value is null
//        ScrollView(.horizontal, showsIndicators: false){
//            HStack(spacing: 10){
//
//                ForEach(self.images, id: \.self){
//                    Image(uiImage: $0)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: UIScreen.main.bounds.width - 115)
//
//                    // .frame(width: 400)
//                    // .scaledToFit()
//                }
//
//            }
//        }
        
        if(imagesElement != nil){
            return AnyView(NewGenericDisplayView(element: imagesElement!, widthOffset: 115))
        } else {
           return AnyView(EmptyView())
        }
    }
}

class ElementWrapper: ObservableObject{
    // observedobject var documentElement
    @ObservedObject var element: Document_Element
    @Published var value: Value? = nil
    //@Published var displayView: AnyView = AnyView(Text("Loading"))
    
    init(element: Document_Element){
        //self.data = data
        self.element = element
    }
    
    func load(){
        
        //            $data
        //               // .subscribe(on: DispatchQueue.main)
        //                .decode(type: Value.self, decoder: JSONDecoder())
        //                .sink(receiveCompletion: { (completion) in
        //                    print("completion")
        //                }) { (value) in
        //                    self.displayView = self.getDisplayView(v: value)
        //            }
        if(self.value == nil){
            DispatchQueue.main.async {
                do {
                    self.value = try JSONDecoder().decode(Value.self, from: self.element.value_private)
                    //self.displayView = self.getDisplayView(v: self.value!)
                } catch{
                    print(error)
                }
            }
        }
        
        
        
        
    }
    
    func getDisplayView(v: Value) -> AnyView{
        switch v{
            
        case .string(let value, let displayType, let editType):
            return AnyView(Text(value).padding(.all, 15))
        case .data(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .dataArray(let value, let displayType, let createType, let editType):
            return AnyView(EmptyView())
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return getPickerDisplay(pickerStruct: value, displayType: displayType, editType: editType)
        case .documentWrapper(let value, let displayType, let editType):
            return AnyView(value.document.dayView)
        case .images(let value, let displayType, let createType, let editType):
            return AnyView(
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10){
                        ForEach(value.map {$0.uiImage}, id: \.self){i in
                            Image(uiImage: i)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
//                            .scaledToFit()
//                                .frame(width: UIScreen.main.bounds.width - widthOffset)
                            //.scaledToFit()
                        }
                    }
            })
        }
        
    }
    
    //func
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
        case .data(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .dataArray(let value, let displayType, let createType, let editType):
            return AnyView(EmptyView())
        case .int(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .date(let value, let displayType, let editType):
            return AnyView(EmptyView())
        case .picker(let value, let displayType, let editType):
            return getPickerDisplay(pickerStruct: value, displayType: displayType, editType: editType)
        case .documentWrapper(let value, let displayType, let editType):
            return AnyView(value.document.dayView)
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
        }
    }
}

struct NewGenericDisplayView: View{
    @ObservedObject var element: ElementWrapper
    var widthOffset: CGFloat
    //var placeholder: [UIImage] = []
    
    init(element: ElementWrapper, widthOffset: CGFloat){
        self.element = element
        self.widthOffset = widthOffset
        self.element.load()
    }
    
    var body: some View{
        if(self.element.value == nil){
            return AnyView(Text("Loading"))
        } else {
            //return AnyView(self.element.value!.displayView)
            return AnyView(DisplayView(widthOffset: widthOffset, value: self.element.value!))
            //  return AnyView(DisplayView(value: self.element.value!))
        }
    }
    
}



class NewValueTestObj: ObservableObject{
    @ObservedObject var documentElement: Document_Element
    @Published var value: Value? = nil
    
    init(documentElement: Document_Element){
        self.documentElement = documentElement
        //self.value = documentElement.value
    }
    
    func loadValue(){
        self.value = documentElement.value
    }
}

struct NewValueTest: View {
    @ObservedObject var obj: NewValueTestObj
    var body: some View {
        VStack{
            if(obj.value == nil){
                Text("loading")
            } else {
                // Text("done loading")
                obj.documentElement.displayView
                // .frame(height: 400)
            }
        }
        .onAppear(){
            self.obj.loadValue()
        }
    }
}

//struct NewValueTest_Previews: PreviewProvider {
//    static var previews: some View {
//        NewValueTest()
//    }
//}
