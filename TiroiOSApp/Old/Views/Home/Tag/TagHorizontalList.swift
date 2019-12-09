//
//  TagHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct TagCard: View {
    var tag: Tag
    
    var body: some View{
        VStack{
            Text(tag.name)
                
            .padding()
                .background(getColor(tag.name))
            .cornerRadius(50)
        }
    }
}

struct TagHorizontalList: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var learner: Learner?
    var activities: [Activity]
    var questions: [Question]
    var learners: [Learner]
    var tags: [Tag]
    @Binding var showTagModal: Bool
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
            SectionTitle("Tags")
                Spacer()
                Button(action: {self.showTagModal = true}) {
                    Image(systemName: "plus.circle")
                    .padding(.trailing, 15)
                }
            }
                
                
            HorizontalScrollList(items: tags, card: {tag in TagCard(tag: tag)}, detail: {(tag: Tag) in
                HomeReusable(
                    store: self.store,
                    learner: self.learner,
                    tag: tag,
                    activities: self.activities.filter {(activity: Activity) in
                        if(activity.tags != nil){
                            let tags: [Tag] = activity.tags!.allObjects as! [Tag]
                            return tags.contains(tag)
                        } else {
                            return false
                        }
                    },
                    questions: [],
                    learners: self.learners,
                    tags: [])})
            }
        }
}
