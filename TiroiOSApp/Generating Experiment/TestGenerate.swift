//
//  TestGenerate.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


/// hmm what's the utility of this? It's not planning. It's just making views more modular. so that people can create more things.

var document = [
    ["type": "boldText",
     "valueType": "String",
    "value": "test text"]
]

/// hmm there's other ways to structure
// do these all need to be high level, or could also be
//
// maybe valueType, displayType, value 

// but with images it would need to be a byte value
// I think we can just have different types
// and currently the only


struct TestGenerate: View {
    var elements  = [textElement, textElement2]
//    var editViews : [MyEditableTextField] {
//        elements.map {$0.getEditable()}
//    }
    @State var editMode = false
    
    var displayView: some View {
        ForEach(elements){el in
            el.getDisplay().onTapGesture {
                self.editMode = true
            }
        }
    }
    
    var editView: some View {
        ForEach(elements){el in
            el.getEditable()
        }
    }
    
    func save(){
        for el in elements{
            //el.save()
            el.store.send(.save)
            //print(el.store.value.value)
            //el.getEditable().save()
//            el.store.send(.save)
        }
    }
    
    var body: some View {
        VStack{
            if(editMode){
                Button(action: {self.save()}){
                    Text("Save")
                }
            }
            Toggle(isOn: $editMode, label: {Text("Edit")})
            Divider()
        if(editMode){
            editView
        } else {
            displayView
        }
        }
    }
}

struct TestGenerate_Previews: PreviewProvider {
    static var previews: some View {
        TestGenerate()
    }
}
