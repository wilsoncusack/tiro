//
//  TagSelect.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/30/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TagSelectRow : View {
    @ObservedObject var selectionManager : MySelectionManager
    var selectableItem : Tag
    
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

struct TagSelectList : View {
    var selectableItems : [Tag]
    @ObservedObject var selectionManager : MySelectionManager
    var body: some View {
        Form{
            Text("Select one or many")
                .italic()
                .foregroundColor(.secondary)
        List(selectableItems){tag in
            TagSelectRow(selectionManager: self.selectionManager, selectableItem: tag)
            }
       }
    }
}



struct TagSelectDetailView : View {
    @EnvironmentObject var data : MainEnvObj
    @ObservedObject var selectionManager : MySelectionManager
    
    var body: some View {
        TagSelectList(selectableItems: data.tagStore.tags, selectionManager: selectionManager)
        }
}

struct TagSelect : View {
    @EnvironmentObject var data : MainEnvObj
    @ObservedObject var selectionManager : MySelectionManager
    
    var tags: [Tag] {
        selectionManager.selectedAsArray as! [Tag]
    }
    
    var body: some View {
        NavigationLink(destination: TagSelectDetailView(selectionManager: selectionManager)){
            HStack{
                Text("Tags")
                Spacer()
                
                ForEach(tags){learner in
                    Text(learner.name)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#if DEBUG
//struct TagSelect_Previews: PreviewProvider {
//    static var previews: some View {
//        TagSelect()
//    }
//}
#endif
