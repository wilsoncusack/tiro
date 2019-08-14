//
//  LearnerSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class MySelectionManager : ObservableObject {
    @Published var selected : Set<AnyHashable>
    
    init(selected: Set<AnyHashable> ){
        self.selected = selected
    }
    
    var selectedAsArray : [AnyHashable] {
        return Array(selected)
    }
    
    func select(_ value: AnyHashable) {
        selected.insert(value)
    }
    
    func deselect(_ value: AnyHashable) {
        selected.remove(value)
    }
    
    func isSelected(_ value: AnyHashable) -> Bool {
        return selected.contains(value)
        
    }
    
    typealias SelectionValue = AnyHashable
}

struct LearnerSelectRow : View {
    @ObservedObject var selectionManager : MySelectionManager
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
        }.onTapGesture {
            if (self.selectionManager.isSelected(self.selectableItem)){
                self.selectionManager.deselect(self.selectableItem)
            } else {
                self.selectionManager.select(self.selectableItem)
            }
        }
    }
}

struct LearnerSelectList : View {
    var selectableItems : [Learner]
    @ObservedObject var selectionManager : MySelectionManager
    var body: some View {
        List(selectableItems){learner in
            LearnerSelectRow(selectionManager: self.selectionManager, selectableItem: learner)
       }
    }
}



struct LearnerSelect : View {
    @EnvironmentObject var data : MainEnvObj
    @ObservedObject var selectionManager : MySelectionManager
    
    var body: some View {
            LearnerSelectList(selectableItems: data.learnerStore.learners, selectionManager: selectionManager)
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
