//
//  LearnerHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/7/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct LearnerHorizontalList: View {
    @ObservedObject var store: Store<AppState, AppAction>
    var tag: Tag?
    var activities: [Activity]
    var questions: [Question]
    var learners: [Learner]
    var tags: [Tag]
    @Binding var showModal: Bool
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
            SectionTitle("Learners")
                Spacer()
                Button(action: {self.showModal = true}) {
                    Image(systemName: "plus.circle")
                    .padding(.trailing, 15)
                }
            }
                
                
            HorizontalScrollList(items: learners, card: {learner in LearnerCard(learner: learner)}, detail: {(learner: Learner) in
                HomeReusable(
                    store: self.store,
                    learner: learner,
                    tag: self.tag,
                    activities: self.activities.filter {(activity: Activity) in
                        let participants: [Learner] = activity.participants?.allObjects as! [Learner]
                        return participants.contains(learner)
                    },
                    questions: self.questions.filter {$0.asker == learner},
                    learners: [],
                    tags: self.tags)})
            }
        }
}


