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
    @State var presentAlert = false
    
    var learners: [User]{
        document.document.associated_users?.allObjects as! [User]
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
                        HStack(alignment: .center, spacing: 2){
//                            Image(systemName: document.document.system_image ?? "")
//                                
//                                .resizable()
//                                .frame(width: 12, height: 12)
//                            .foregroundColor(.secondary)
//                                .padding(.trailing, 2)
                                //.foregroundColor(.secondary)
                            Text(getDocumentTypeString(type: document.document.type))
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .bold()
                                .padding(.trailing, 2)
                            PickerLearnersView(learners: learners, displayType: .participants, font: .caption)
//                            if(!learners.isEmpty){
//                                Text("with")
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                            } else {
//                                EmptyView()
//                            }
//                            ForEach(learners){learner in
//                                HStack{
//                                    Text(learner.first_name)
//                                        .font(.caption)
//                                        .foregroundColor(.secondary)
//                                }
//
//                            }
                        }.padding(.bottom, 10)
                        
                        DocumentLoadableRowView(doc: document)
                        
                    }
                    Spacer()
                }
                
                
            }.buttonStyle(PlainButtonStyle())
                .padding(.bottom, 10)
            
            TagsRowView(document: document)
            .padding(.leading, 70)
        }
//        .onLongPressGesture {
//                   self.presentAlert = true
//               }
//    
//               .alert(isPresented: self.$presentAlert){
//                Alert(title: Text("Do you want to delete this element?"), primaryButton: Alert.Button.destructive(Text("Delete")){
//                    self.document.delete()
//                }, secondaryButton: .cancel())
//               }
    }
}

//struct DayRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayRowView()
//    }
//}
