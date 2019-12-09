//
//  UserPicker.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/2/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class ValueEditableGeneric<aValue>: ObservableObject {
    //@ObservedObject var tEl: TransientDocumentElement
   // var update: (aValue) -> Void
    //@Published var value: aValue
    var listener : AnyCancellable?
    
    init(value: Published<aValue>.Publisher, update: @escaping (aValue) -> Void){
       // self.tEl = tEl
        //self.value = value
       // self.update = update
        self.listener = value.sink { (v) in
            //print("received value")
            print("calling update")
            update(v)
        }
    }
    
    deinit {
        print("cancelling")
        listener!.cancel()
    }
}

struct UserPicker: View {
    @ObservedObject var obj: ValueEditableGeneric<[User]>
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.first_name, ascending: true)])
    var users: FetchedResults<User>
    @ObservedObject var pickerManager: GenericSelectionManager<User>
    var body: some View {
        MultiSelect(title: "Participants", selectionManager: pickerManager, choices: users.map {$0}, getName: {$0.first_name})
//        .onDisappear(){
//            print("disappear")
//            self.obj.listener!.cancel()
//        }
    }
    
}

//struct UserPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPicker()
//    }
//}
