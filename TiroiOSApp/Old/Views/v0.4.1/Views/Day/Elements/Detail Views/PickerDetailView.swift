//
//  PickerDetailView.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/2/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

enum DisplayMode {
    case row
    case detail
}

struct PickerDetailView: View {
    var picker: PickerStruct
    var displayMode: DisplayMode
    var selected: [String]
    var string = ""
    var content: AnyView
    
    init(picker: PickerStruct, displayMode: DisplayMode){
        self.picker = picker
        self.displayMode = displayMode
        self.selected = picker.selected
        self.content = AnyView(EmptyView())
        if(picker.isCoreData){
            switch picker.coreDataType!{
                
            case .learner:
                var learners = picker.selected
                    .map { getLearnerByID(id: $0) }
                    .filter {$0 != nil}
                    .map {$0!}
                self.content = AnyView(PickerLearnersView(learners: learners))
                
            case .tag:
                var tags = picker.selected
                    .map { getTagByID(id: $0) }
                    .filter {$0 != nil}
                    .map {$0!}
                self.content = AnyView(PickerTagsView(tags: tags))
            }
        }
        
        
    }
    
    var body: some View {
       content
    }
}

struct PickerTagsView: View {
    var tags: [Tag]
    
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
//        .padding()
//            .padding(.bottom, 0)
            Spacer()
        }
        }
    
        //.padding(.leading, 15)
    }
}

struct PickerLearnersView: View {
    var learners: [Learner]
    
    var str: String? {
        if(learners.count == 0){
            return nil
        }
        return "Participants: " + learners
            .map {$0.name}
            .joined(separator: ", ")
    }
    
    var body: some View{
        VStack(alignment: .leading){
            if(str != nil){
        HStack{
            
            
           Text(str!)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.all, 5)
            
        
            Spacer()
                }
                }
            else {
                EmptyView()
            }
            
        
        }
//        .padding()
//        .padding(.bottom, 0)
    }
}

//struct PickerDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerDetailView()
//    }
//}
