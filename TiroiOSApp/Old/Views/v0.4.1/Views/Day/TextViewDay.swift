//
//  TextViewDay.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

//struct TextViewDay: View {
//    @ObservedObject var document: Document
//    var elements :  [Document_Element] {
//        return document.elements?.allObjects as! [Document_Element]
//    }
//    
//    // this feels wrong
//    func getText(element: Document_Element) -> String? {
//        switch element.value!{
//        
//        case .string(let value, let displayType, let editType):
//            return value
//        default:
//            return nil
//        }
//    }
//    
//    
//    var text: String {
//        var texts = elements.map {getText(element: $0)}.filter {$0 != nil}
//        if(texts.count > 0){
//        return texts[0]!
//        } else {
//            return ""
//        }
//    }
//    
//    var learners: [Learner]{
//        document.associated_users?.allObjects as! [Learner]
//    }
//    
//    var tags: [Tag]{
//           document.tags?.allObjects as! [Tag]
//       }
//    
//    var body: some View{
//
//            
//        VStack(alignment: .leading){
//        Text(text)
//        }
//    }
//}
