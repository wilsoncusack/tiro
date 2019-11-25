//
//  BasicDayElement.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct BasicDayRow: View {
    @ObservedObject var document: Document
//     @State var dragOffset = CGSize.zero
    var learners: [Learner]{
        document.associated_users?.allObjects as! [Learner]
    }
    
    var tags: [Tag]{
           document.tags?.allObjects as! [Tag]
       }
    
    var body: some View{
        VStack(alignment: .leading){
        NavigationLink(destination: document.detailView){
            HStack(alignment: .top){
                          HStack{
                              // this date stuff should be somewhere else
                          Text(hourAndMinute.string(from: document.date))
                            .font(.caption)
                              .foregroundColor(.secondary)
                              Spacer()
                          }
                              .frame(width: 70)
                VStack(alignment: .leading){
                    HStack(alignment: .top, spacing: 2){
                Text(getDocumentTypeString(type: document.type))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .bold()
                    .padding(.trailing, 2)
                //.padding(.bottom, 10)
                        
                        if(!learners.isEmpty){
                                    Text("with")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                     } else {
                                        EmptyView()
                                    }
                                    ForEach(learners){learner in
                                        HStack{
                        //                    ProfileImage(learner: learner, size: 25)
                                        Text(learner.name)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        }
                                       
                                    }
                    }.padding(.bottom, 10)
            
                document.dayView//.frame(height: 600)
                   // .padding(.bottom, 10)
                    
            }
                          Spacer()
                       // Image(systemName: "trash")
                      }//.frame(width: UIScreen.main.bounds.width + 50)

            
        }.buttonStyle(PlainButtonStyle())
             .padding(.bottom, 10)
                
                VStack(alignment: .leading){
//                    HStack(spacing: 2){
//             if(!learners.isEmpty){
//            Text("with")
//            .font(.caption)
//            .foregroundColor(.secondary)
//             } else {
//                EmptyView()
//            }
//            ForEach(learners){learner in
//                HStack{
////                    ProfileImage(learner: learner, size: 25)
//                Text(learner.name)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                }
//
//            }
//        }.padding(.bottom, 5)
        
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
                }.padding(.leading, 70)
        }
        
    }
}

struct BasicDayRow2: View {
    @ObservedObject var document: DocumentWrapper2
//     @State var dragOffset = CGSize.zero
    var learners: [Learner]{
        document.document.associated_users?.allObjects as! [Learner]
    }
    
  
    
    var body: some View{
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
            
                document.RowView//.frame(height: 600)
                   // .padding(.bottom, 10)
                    
            }
                          Spacer()
                       // Image(systemName: "trash")
                      }//.frame(width: UIScreen.main.bounds.width + 50)

            
        }.buttonStyle(PlainButtonStyle())
             .padding(.bottom, 10)
                
            TagsRowView(document: document)
        }
        
    }
}

struct TagsRowView: View{
    @ObservedObject var document: DocumentWrapper2
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
                }.padding(.leading, 70)
    }
}

