//
//  GenericSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/4/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

class GenericSelectionManager<Item>: ObservableObject where Item: Hashable {
    @Published var selected : Set<SelectionValue>
    
    init(_ passedSelected: [SelectionValue] ){
        self.selected = Set(passedSelected)
    }
    
    var selectedAsArray : [SelectionValue] {
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
    
    
    typealias SelectionValue = Item
}

struct MultiSelectRow<Item>: View where Item: Hashable{
    var selectableItem: Item
    var getName: (Item) -> String
    @ObservedObject var selectionManager: GenericSelectionManager<Item>
    
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

struct MultiSelectList<Item>: View where Item: Hashable {
    @ObservedObject var selectionManager : GenericSelectionManager<Item>
    var choices: [Item]
    var getName: (Item) -> String
    
    
    var body: some View{
        VStack{
            Text("Select one or many")
                .foregroundColor(.secondary)
                .padding()
        List(choices, id: \.self){choice in
            MultiSelectRow(selectableItem: choice, getName: self.getName, selectionManager: self.selectionManager)
        }
        }
    }
}

struct MultiSelect<Item>: View where Item: Hashable{
    var title: String
    @ObservedObject var selectionManager : GenericSelectionManager<Item>
    var choices: [Item]
    var getName: (Item) -> String
    
    func itemString(_ items: [Item]) -> String {
        var str = ""
        for item in items {
            str += getName(item) + "  "
        }
        return str
    }
    
    var body: some View {
        NavigationLink(destination: MultiSelectList(selectionManager: selectionManager, choices: choices, getName: getName)){
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

//struct GenericSelect_Previews: PreviewProvider {
//    static var previews: some View {
//        GenericSelect()
//    }
//}
