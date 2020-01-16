//
//  Multi2.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class GenericSelectionManager3<Item>: ObservableObject where Item: Hashable {
    @Published var selected : Set<SelectionValue>
    //@Binding var passedSelected: [SelectionValue]
//    var listener: AnyCancellable?
    
//    init(_ passedSelected: Binding<[SelectionValue]>){
//        //self.passedSelected = passedSelected.wrappedValue
//        self.selected = Set(passedSelected.wrappedValue)
//        self.listener = self.$selected.sink(receiveValue: { (itemSet) in
//            passedSelected.wrappedValue = Array(itemSet)
//        })
//    }
    
    init(_ passedSelected: [SelectionValue]){
           //self.passedSelected = passedSelected.wrappedValue
           self.selected = Set(passedSelected)
           
       }
    
//    deinit{
//        self.listener?.cancel()
//    }
    
    var selectedAsArray : [SelectionValue] {
        return Array(selected)
    }
    
    func select(_ value: SelectionValue) {
        //AnySubj $selected
        selected.insert(value)
    }
    
    func deselect(_ value: SelectionValue) {
        selected.remove(value)
    }
    
    func isSelected(_ value: SelectionValue) -> Bool {
        return selected.contains(value)
        
    }
    
    
    typealias SelectionValue = Item
}

struct MultiSelectRow3<Item>: View where Item: Hashable{
    var selectableItem: Item
    var getName: (Item) -> String
    @ObservedObject var selectionManager: GenericSelectionManager3<Item>
    var choiceLimit: Int
    
    var isSelected: Bool {
        self.selectionManager.isSelected(self.selectableItem)
    }
    
    var body: some View {
        HStack{
            ZStack{
                Image(systemName: (isSelected ? "largecircle.fill.circle" : "circle"))
                    .resizable()
                .frame(width: 30, height: 30)
                    .foregroundColor(isSelected ? .yellow : .secondary)
//            if(self.selectionManager.isSelected(self.selectableItem)) {
//                    Circle()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.yellow)
//                }
//                Circle()
//                    .stroke(Color.gray, lineWidth: 2)
//                    .frame(width: 30, height: 30)
//                    .foregroundColor(.white)
            }
            Text(getName(selectableItem)).padding(.leading, 10)
        }.onTapGesture {
            
            if (self.selectionManager.isSelected(self.selectableItem)){
                self.selectionManager.deselect(self.selectableItem)
            } else {
                if(self.selectionManager.selected.count == self.choiceLimit){
                    return
                }
                self.selectionManager.select(self.selectableItem)
            }
        }
    }
}

struct MultiSelectList3<Item>: View where Item: Hashable {
    @ObservedObject var selectionManager : GenericSelectionManager3<Item>
    var choiceLimit: Int
    var choices: [Item]
    var getName: (Item) -> String
    var done: ([Item]) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var header: String {
        if(choiceLimit == Int.max){
        return "Select one or many"
        } else if (choiceLimit == 1){
            return "Choose 1"
        } else {
        return "Select up to \(choiceLimit.description)"

        }
    }
    
    
    var body: some View{
        Form{
            
            Section(header: Text(header)
                .foregroundColor(.secondary)
            ){
        List(choices, id: \.self){choice in
            MultiSelectRow3(selectableItem: choice, getName: self.getName, selectionManager: self.selectionManager, choiceLimit: self.choiceLimit)
        }
        }
        }
        .navigationBarItems(leading: Button(action: {
            self.done(self.selectionManager.selectedAsArray)
            self.presentationMode.wrappedValue.dismiss()
        }){
            HStack{
            Image(systemName: "chevron.left")
//            .resizable()
//                .frame(width: 25, height: 25)
//                .aspectRatio(contentMode: .fill)
                Text("Back")
            }
            }
        )
    }
}

struct MultiSelect3<Item>: View where Item: Hashable{
    var title: String
    //@ObservedObject var selectionManager : GenericSelectionManager<Item>
    @ObservedObject var observedSelected: ObservableValue<[Item]>
    var choiceLimit: Int
    var choices: [Item]
    var getName: (Item) -> String
    
    
    func done(items: [Item]){
        print("done called")
        self.observedSelected.value = items
    }
    
    var selectionManager: GenericSelectionManager3<Item>{
        return GenericSelectionManager3(observedSelected.value)
    }
    
    func itemString(_ items: [Item]) -> String {
        var str = ""
        for item in items {
            str += getName(item) + "  "
        }
        return str
    }
    
    var body: some View {
        NavigationLink(destination: MultiSelectList3(selectionManager: selectionManager, choiceLimit: choiceLimit, choices: choices, getName: getName, done: done)){
            HStack{
                Text(title)
                Spacer()
                Text(itemString(selectionManager.selectedAsArray))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
    }
}

//struct Multi2_Previews: PreviewProvider {
//    static var previews: some View {
//        Multi2()
//    }
//}
