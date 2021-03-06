//
//  MultiSelect2.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/4/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//
//  GenericSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/4/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

class GenericSelectionManager2<Item>: ObservableObject where Item: Hashable {
    //var selectedArray : Binding<[Item]>
    @Published var selected : Set<SelectionValue>
    
    init(_ passedSelected: [SelectionValue] ){
        self.selected = Set(passedSelected)
        //self.selectedArray = passedSelected
    }
    
    var selectedAsArray : [SelectionValue] {
       // var save =  Array(selected)
        //self.selectedArray.wrappedValue =  Array(selected)
        return Array(selected)
    }
    
    func select(_ value: SelectionValue) {
        selected.insert(value)
    }
    
    func deselect(_ value: SelectionValue) {
        selected.remove(value)
    }
    
    func isSelected(_ value: SelectionValue) -> Bool {
        return selected.contains(value)
        
    }
    
//    deinit {
//        selectedArray.wrappedValue = Array(selected)
//    }
    
    
    typealias SelectionValue = Item
}

struct MultiSelectRow2<Item>: View where Item: Hashable{
    var selectableItem: Item
    var getName: (Item) -> String
    @ObservedObject var selectionManager: GenericSelectionManager2<Item>
    
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
            Text(getName(selectableItem)).padding(.leading, 10)
        }.onTapGesture {
            if (self.selectionManager.isSelected(self.selectableItem)){
                self.selectionManager.deselect(self.selectableItem)
            } else {
                self.selectionManager.select(self.selectableItem)
            }
        }
    }
}

struct MultiSelectList2<Item>: View where Item: Hashable {
    @ObservedObject var selectionManager : GenericSelectionManager2<Item>
    var choices: [Item]
    var getName: (Item) -> String

    
    var body: some View{
        List(choices, id: \.self){choice in
            MultiSelectRow2(selectableItem: choice, getName: self.getName, selectionManager: self.selectionManager)
        }
    }
}

struct MultiSelect2<Item>: View where Item: Hashable{
    var title: String
    //@ObservedObject var selectionManager : GenericSelectionManager2<Item>
    var selected: Binding<[Item]>
    var choices: [Item]
    var getName: (Item) -> String
    var selectionManager : GenericSelectionManager2<Item>
    
    init(title: String, selected: Binding<[Item]>, choices: [Item], getName: @escaping (Item) -> String){
        self.title = title
        self.selected = selected
        self.choices = choices
        self.getName = getName
        
        self.selectionManager = GenericSelectionManager2(selected.wrappedValue)
        
        var _ = selectionManager.$selected.sink { aSet in
            selected.wrappedValue = Array(aSet)
        }
    }
    
    func itemString(_ items: [Item]) -> String {
        var str = ""
        for item in items {
            str += getName(item) + "  "
        }
        return str
    }
    
    var body: some View {
        NavigationLink(destination: MultiSelectList2(selectionManager: selectionManager, choices: choices, getName: getName)){
            HStack{
                Text(title)
                Spacer()
                Text(itemString(selectionManager.selectedAsArray))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
//        .onReceive(selectionManager.$selected) { aSet in
//            print("received")
//            //self.selected = Array(aSet)
//        }
    }
}

//struct GenericSelect_Previews: PreviewProvider {
//    static var previews: some View {
//        GenericSelect()
//    }
//}


