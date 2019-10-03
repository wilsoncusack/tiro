////
////  TestHorizontal.swift
////  TiroiOSApp
////
////  Created by Wilson Cusack on 10/1/19.
////  Copyright © 2019 Wilson Cusack. All rights reserved.
////
//
//import SwiftUI
//
//@ViewBuilder
//func learnerCardTest(learner: Learner) -> LearnerCard {
//    LearnerCard(learner: learner)
//}
//
//struct TestHorizontal: View {
//    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
//    var learners: FetchedResults<Learner>
//
//    var body: some View {
////         HorizontalList(items: learners, card: learnerCardTest, detail: learnerCardTest)
//        HorizontalList(items: learners, card: {learner in LearnerCard(learner: learner)}, detail: {learner in NewLearnerDetail(learner: learner)})
//    }
//}
//
//struct TestHorizontal_Previews: PreviewProvider {
//    static var previews: some View {
//        TestHorizontal()
//    }
//}
