//
//  HorizontalScrollList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/3/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

struct HorizontalScrollList<Item, Card, Detail>: View where Item: NSManagedObject, Card: View, Detail: View{
    var items: [Item]
    var card: (Item) -> Card
    var detail: (Item) -> Detail
    
    
    var body: some View{
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 10){
                    ForEach(items, id: \.self){item in
                        NavigationLink(destination: self.detail(item)){
                            self.card(item)
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                }.padding(.leading, 15).padding(.trailing, 15)
                
            }
        }
    }
}

//struct HorizontalScrollList_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalScrollList()
//    }
//}
