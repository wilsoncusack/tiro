//
//  SearchRowView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/11/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct SearchRowView: View {
    @ObservedObject var document: DocumentLoadable
    
    var learners: [User]{
        document.document.associated_users?.allObjects as! [User]
    }
    
    var body: some View {
            
                VStack(alignment: .leading){
                    HStack{
                        
                        // this date stuff should be somewhere else
                         Text(hourAndMinute.string(from: document.document.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        Text(longDateFormatter.string(from: document.document.date))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        //Divider()
                        Spacer()

                    }
                        .padding(.top, 20)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                
                    //.frame(width: 70)
                    //VStack(alignment: .center){
                    VStack(alignment: .leading){
                        NavigationLink(destination: document.DetailView){
                            HStack{
                                VStack(alignment: .leading){
                        HStack(alignment: .top, spacing: 2){
                            Text(getDocumentTypeString(type: document.document.type))
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .bold()
                                .padding(.trailing, 2)
                            PickerLearnersView(learners: learners, displayType: .participants, font: .caption)
                            
                            
                        }.padding(.bottom, 10)
                        
                                DocumentLoadableRowView(doc: document)
                                }
                                Spacer()
                            }
                        
                    }.buttonStyle(PlainButtonStyle())
                            .padding(.top, 10)
                        .padding(.bottom, 10)
                            .padding(.leading, 15)
                        .padding(.trailing, 15)
                        
                    TagsRowView(document: document)
                    .padding(.bottom, 10)
                         .padding(.leading, 15)
                       // Divider().padding(.leading, 10)
//
                }
                    
                    .frame(width: UIScreen.main.bounds.width - 20)
                .background(Color(UIColor.systemBackground))
//                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.secondary, lineWidth: 0.5)
                    )
                .cornerRadius(4)
                    .padding(.leading, 10)
//                    .shadow(color: Color(UIColor.systemGray4), radius: 5, x: 0, y: 0)
                   // }
                    
                
                
            }.frame(width: UIScreen.main.bounds.width)
        
        
    }
}

//struct SearchRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchRowView()
//    }
//}
