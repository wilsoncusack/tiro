//
//  BasicDayElement.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


struct TagsRowView: View{
    @ObservedObject var document: DocumentLoadable
    var tags: [Tag]{
          document.document.tags?.allObjects as! [Tag]
         }
    
    var body: some View{
        VStack(alignment: .leading){
        
        HStack{
            ForEach(tags){tag in
                Text(tag.name)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .padding(.all, 5)
                    .background(Color(UIColor.systemGray6))
                                   .cornerRadius(8)
            }
        
        
        }
                }
    }
}

