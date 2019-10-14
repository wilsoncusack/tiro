//
//  SingleSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct SingleSelectRow<Item>: View where Item: Hashable{
    var selectableItem: Item
    @Binding var chosen : Item?
    var getName: (Item) -> String
    
    var body: some View {
        HStack{
            ZStack{
            if(chosen != nil && selectableItem == chosen!) {
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
            self.chosen = self.selectableItem
        }
    }
}

struct SingleSelectList<Item>: View where Item: Hashable {
    @Binding var chosen : Item?
    var choices: [Item]
    var getName: (Item) -> String
    
    
    var body: some View{
        VStack{
            Text("Select one")
                .foregroundColor(.secondary)
                .padding()
        List(choices, id: \.self){choice in
            SingleSelectRow(selectableItem: choice, chosen: self.$chosen, getName: self.getName)
        }
        }
    }
}

struct SingleSelect<Item>: View where Item: Hashable{
    var title: String
    @Binding var chosen: Item?
    var choices: [Item]
    var getName: (Item) -> String
    
    
    var body: some View {
        NavigationLink(destination: SingleSelectList(chosen: $chosen ,choices: choices, getName: getName)){
            HStack{
                Text(title)
                Spacer()
                Text(chosen != nil ? getName(chosen!) : "")
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
    }
}
