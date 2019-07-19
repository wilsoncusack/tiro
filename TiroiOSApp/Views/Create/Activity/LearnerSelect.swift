//
//  LearnerSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class mySelectionManager : SelectionManager, BindableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    var selectedLearners = Set<AnyHashable>(){
        willSet{
            willChange.send(())
        }
    }
    
    var selectedAsArray : [AnyHashable] {
        Array(selectedLearners)
    }
    
    func select(_ value: AnyHashable) {
        willChange.send()
        selectedLearners.insert(value)
    }
    
    func deselect(_ value: AnyHashable) {
        willChange.send()
        selectedLearners.remove(value)
    }
    
    func isSelected(_ value: AnyHashable) -> Bool {
        return selectedLearners.contains(value)
        
    }
    
    typealias SelectionValue = AnyHashable
}

struct SelectRow : View {
    @ObjectBinding var selectionManager : mySelectionManager
    var learner : Learner
//    var isSelected : Bool {
//        selectionManager.isSelected(learner)
//    }

    var body: some View {
        HStack{
            Image(systemName: self.selectionManager.isSelected(self.learner) ? "circle.fill" : "circle")
            Text(learner.name)
        }.tapAction {
            if(self.selectionManager.isSelected(self.learner)){
                self.selectionManager.deselect(self.learner)
            }else{
                self.selectionManager.select(self.learner)
            }
        }
    }
}



struct LearnerSelect : View {
    @EnvironmentObject var data : DemoData
    @ObjectBinding var selectionManager = mySelectionManager()
    var learners : [Learner] {
        selectionManager.selectedAsArray as! [Learner]
    }
    
    var body: some View {
        VStack{
            HStack{
            Text("Selected: \(selectionManager.selectedLearners.count)")
            ForEach(learners){learner in
                Text(learner.name)
                }
                
            }
                    List(data.learnerStore.learners){learner in
                        SelectRow(selectionManager: self.selectionManager, learner: learner)
                    }
            Button(action: {}){
                Text("New")
            }
        }
    }
}

#if DEBUG
struct LearnerSelect_Previews : PreviewProvider {
    //static var data = DemoData()
    static var previews: some View {
        LearnerSelect().environmentObject(DemoData())
    }
}
#endif
