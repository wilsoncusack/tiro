//
//  AddLearners.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


struct AddLearners : View {
    @ObservedObject var store: Store<AppState, AppAction>
    @State var showModal = false
    
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    
    var body: some View {
        NavigationView{
        VStack {
            Text("Great! Now let's add your learners")
                .padding(.top, 20)
            Button(action: {self.showModal.toggle()}){
                HStack{
                    Image(systemName: "person.badge.plus.fill")
                    Text("Add Learner")
                }
            }.padding()
            
            if(learners.count > 0){
                VStack(alignment: .leading){
                    Divider()
                    Text("Learners")
                        .font(.title)
                        .bold()
                        .padding(.leading, 15)
                    .padding(.bottom, 15)
                
                ForEach(learners){learner in
                    HStack {
                        ProfileImage(learner: learner, size : 50)
                        Text(learner.name)
                            .font(.title)
                    }.padding(.leading, 15)
                }
                }
                
            }
            Spacer()
            Button(action: {
                if(self.learners.count > 0 ){
                    self.store.send(.setup(.finish))
                }
                }){
                Text("Done")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.95)
                    .background(learners.count > 0 ? Color.blue : Color.gray)
                    .cornerRadius(8)
            }.padding(.bottom, 15)
        }
        .navigationBarTitle("Add Learners", displayMode: .inline)
            .sheet(isPresented: $showModal, content: {LearnerCreateModal(
                store: self.store.view(
                    value: {$0.learnerState},
                    action: {.learner($0)}
                ),
                showModal: self.$showModal)})
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

