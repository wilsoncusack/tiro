//
//  DayRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI


struct DayRowView: View {
    @ObservedObject var document: DocumentLoadable
    
    var learners: [Learner]{
        document.document.associated_users?.allObjects as! [Learner]
    }
    
    var body: some View {
        VStack(alignment: .leading){
            NavigationLink(destination: document.DetailView){
                HStack(alignment: .top){
                    HStack{
                        // this date stuff should be somewhere else
                        Text(hourAndMinute.string(from: document.document.date))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .frame(width: 70)
                    VStack(alignment: .leading){
                        HStack(alignment: .top, spacing: 2){
                            Text(getDocumentTypeString(type: document.document.type))
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .bold()
                                .padding(.trailing, 2)
                            if(!learners.isEmpty){
                                Text("with")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } else {
                                EmptyView()
                            }
                            ForEach(learners){learner in
                                HStack{
                                    Text(learner.name)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                            }
                        }.padding(.bottom, 10)
                        
                        DocumentLoadableRowView(doc: document)
                        
                    }
                    Spacer()
                }
                
                
            }.buttonStyle(PlainButtonStyle())
                .padding(.bottom, 10)
            
            TagsRowView(document: document)
        }
    }
}

//struct DayRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayRowView()
//    }
//}
