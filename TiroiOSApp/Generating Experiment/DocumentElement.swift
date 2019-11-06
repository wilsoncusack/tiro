//
//  DocumentElement.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

//class DocumentElement<Value, Action, EditableView, DisplayView> where EditableView: View, DisplayView: View {
//    var store: Store<Value, Action>
//
//    var getEditable: (Store<Value, Action>, String) -> EditableView
//    var getDisplay: (Store<Value, Action>) -> DisplayView
//
//    init(store: Store<Value, Action>,
//         @ViewBuilder getEditable: @escaping (Store<Value, Action>, String) -> EditableView,
//                      @ViewBuilder getDisplay: @escaping (Store<Value, Action>) -> DisplayView){
//        self.store = store
//        self.getEditable = getEditable
//        self.getDisplay = getDisplay
//    }
//
//}

class DocumentElement<Value, Action, EditableView, DisplayView> : Identifiable where EditableView: View, DisplayView: View {
    
    var id: UUID
    var store: Store<Value, Action>
    
    //var getEditable: (Store<Value, Action>, String) -> EditableView
    var getEditable: () -> EditableView
//    var getDisplay: (Store<Value, Action>) -> DisplayView
    var getDisplay: () -> DisplayView
    var save: () -> Void
    
    init(title: String, store: Store<Value, Action>,
         @ViewBuilder getEditable: @escaping (Store<Value, Action>, String) -> EditableView,
                      @ViewBuilder getDisplay: @escaping (Store<Value, Action>) -> DisplayView, save: @escaping (Store<Value, Action>) -> Void){
        self.id = UUID()
        self.store = store
        self.getEditable = {getEditable(store, title)}
        self.getDisplay = {getDisplay(store) }
        self.save = {save(store)}
    }
}

// I wonder if there's a way to do this where it's just all in the store

var textElement = DocumentElement(title: "Text", store: textStore, getEditable: textGetEditable, getDisplay: textGetDisplay, save: {store in store.send(.save)})
var textElement2 = DocumentElement(title: "More Text", store: Store(initialValue: TextState(title: "Title", value: "new value"), reducer: TextElementReducer), getEditable: textGetEditable, getDisplay: textGetBoldDisplay, save: {store in store.send(.save)})

enum TextElementAction {
    case create(text: String)
    case edit(text: String)
    case save
}

func TextElementReducer(state: inout TextState, action: TextElementAction){
    switch action{
        
    case .create(let text):
        state.value = text
    case .edit(let text):
        print("in edit with: \(text)")
        state.editValue  = text
       // state.value = text
    
//    case .save:
//        print("editValue")
//    state.value = state.editValue
    case .save:
        state.value = state.editValue
        print("here")
    }
}

class TextState: ObservableObject {
    var title: String
    var value: String
    var editValue: String
    
    init(title: String, value: String){
        self.title = title
        self.value = value
        self.editValue = value
    }
}

var textState = TextState(title: "Text Title", value: "test")
var textStore = Store(initialValue: textState, reducer: TextElementReducer)


func textGetBoldDisplay(store: Store<TextState, TextElementAction>) -> Text {
    Text(store.value.value).bold()
}

func textGetDisplay(store: Store<TextState, TextElementAction>) -> Text {
    Text(store.value.value)
}

func textGetEditable(store: Store<TextState, TextElementAction>, title: String) -> MyEditableTextField {
    MyEditableTextField(store: store, title: title, value: store.value.editValue)
}



//maybe val





struct MyEditableTextField: View {
    @ObservedObject var store: Store<TextState, TextElementAction>
    var title: String
    @State var value: String
    
    var body: some View {
        TextField(store.value.title, text: $value, onEditingChanged: {_ in self.store.send(.edit(text: self.value))}, onCommit: {self.store.send(.edit(text: self.value))})
        .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
    }
}


// hmm, so on edit we need the ability to
//
//

/// what do I want to be able to call
// for each in the elements
// get the display version
// on edit, get the editable version
// on save, map save


// so on create, create a new bindabl version
// save should probably take the stores
// editable version
// or else we can call save on the individual element
