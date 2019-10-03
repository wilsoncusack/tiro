//
//  LearnerHorizontalList.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 9/26/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

/// I could probably drop the including of the detail view and just attach it to the card, or pass in a navigation link

//struct HorizontalList2<Card, Detail>: View where Card: View, Detail: View{
//    var links: [NavigationLink<Card, Detail>]
//
//    var body: some View {
//        VStack{
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(alignment: .bottom, spacing: 10){
//                    ForEach(links, id: \.self){link in
//                        link
//                    }
//                }.padding(.leading, 15)
//
//            }
//        }
//    }
//}

struct HorizontalList<Item, Card, Detail>: View where Item: NSManagedObject, Card: View, Detail: View{
    var items: [Item]
    var card: (Item) -> Card
    var detail: (Item) -> Detail
    
//    init(items: FetchedResults<Item>, @ViewBuilder card: @escaping (Item) -> Card, @ViewBuilder detail: @escaping (Item) -> Detail) {
//        self.items = items
//        self.card = card
//        self.detail = detail
//    }
    
    
    var body: some View{
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 10){
                    ForEach(items, id: \.self){item in
                        NavigationLink(destination: self.detail(item)){
                            self.card(item)
                        }.buttonStyle(PlainButtonStyle())
                        
                    }
                }.padding(.leading, 15)
                
            }
        }
    }
}

struct LearnersHorizontalList: View {
    @EnvironmentObject var mainEnv: MainEnvObj
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    @Binding var showModal : Bool
    @Binding var selectedLearner : Learner?
    @Binding var modalKind : String
    
    
    var body: some View{
        
        VStack{
            HStack {
                Text("Learners")
                    .font(.system(size: 22))
                    .bold()
                    .padding(.leading, 15)
                Spacer()
                Button(action: {
                    self.showModal = true
                    self.modalKind = "learnerCreate"
                    
                }){
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .padding(.trailing, 15)
                }
                
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 10){
                    ForEach(learners){learner in
                        VStack{
                            ProfileImage(learner: learner, size: 100)
                            Text(learner.name)
                        }.onTapGesture {
                            self.showModal = true
                            self.selectedLearner = learner
                            self.modalKind = "learnerEdit"
                        }
                    }
                }.padding(.leading, 15)
                
            }
        }
        //        .sheet(isPresented: $showModal) {
        //            if(self.selectedLearner != nil){
        //                LearnerDetail(showModal: self.$showModal, learner: self.selectedLearner!).environmentObject(self.mainEnv)
        //            }
        //        }
    }
    
}

//struct LearnersHorizontalList_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnersHorizontalList()
//    }
//}
