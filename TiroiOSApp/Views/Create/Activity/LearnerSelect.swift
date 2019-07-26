//
//  LearnerSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class MySelectionManager : SelectionManager, BindableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    var selected : Set<AnyHashable> {
        willSet{
            willChange.send(())
        }
    }
    
    init(selected: Set<AnyHashable> ){
        self.selected = selected
    }
    
    var selectedAsArray : [AnyHashable] {
        return Array(selected)
    }
    
    func select(_ value: AnyHashable) {
        willChange.send()
        selected.insert(value)
    }
    
    func deselect(_ value: AnyHashable) {
        willChange.send()
        selected.remove(value)
    }
    
    func isSelected(_ value: AnyHashable) -> Bool {
        return selected.contains(value)
        
    }
    
    typealias SelectionValue = AnyHashable
}

protocol SelectableItemProtocol : Hashable, Identifiable {
    var id: UUID {get set}
    var name : String {get set}
}

struct SelectableItem : SelectableItemProtocol {
    var id: UUID
    var name : String
}

struct SelectRow : View {
    @ObjectBinding var selectionManager : MySelectionManager
    var selectableItem : Learner
    
    var body: some View {
        HStack{
            ZStack{
                if(self.selectionManager.isSelected(self.selectableItem)) {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.yellow)
                }
                Circle()
                    .stroke(Color.gray, lineWidth: 2)
                   .frame(width: 30, height: 30)
                    .foregroundColor(.white)
            }
            Text(selectableItem.name).padding(.leading, 10)
        }.tapAction {
            if(self.selectionManager.isSelected(self.selectableItem)){
                self.selectionManager.deselect(self.selectableItem)
            }else{
                self.selectionManager.select(self.selectableItem)
            }
        }
    }
}

struct Select : View {
    var selectableItems : [Learner]
    //@Binding var selected : Set<Learner>
    @ObjectBinding var selectionManager : MySelectionManager
    var body: some View {
        List(selectableItems){learner in
            SelectRow(selectionManager: self.selectionManager, selectableItem: learner)
       }
    }
}



struct LearnerSelect : View {
    @EnvironmentObject var data : MainEnvObj
    //@Binding var selected : Set<Learner>
    @ObjectBinding var selectionManager : MySelectionManager
//    var learners : [Learner] {
//        selectionManager.selectedAsArray as! [Learner]
//    }
    
    var body: some View {
            Select(selectableItems: data.learnerStore.learners, selectionManager: selectionManager)
        }
}

#if DEBUG
//struct LearnerSelect_Previews : PreviewProvider {
//   // @EnvironmentObject static var data = MainEnvObj()
//    @ObjectBinding static var selectionManager = MySelectionManager(selected: )
//    static var previews: some View {
//        LearnerSelect(selectionManager: selectionManager).environmentObject(MainEnvObj())
//    }
//}
#endif
