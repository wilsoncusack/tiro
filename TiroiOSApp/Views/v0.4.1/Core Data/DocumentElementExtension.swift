//
//  DocumentElementExtension.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI

extension Document_Element{
    func getDisplayView() -> AnyView {
        if(self.value == nil){
            return AnyView(EmptyView())
        } else {
            switch self.value!{
                
            case .string(let value, let displayType, let editType):
                return AnyView(Text(value))
            case .data(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .int(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .date(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .picker(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            case .document(let value, let displayType, let editType):
                 return AnyView(EmptyView())
            }
        }
    }
}
