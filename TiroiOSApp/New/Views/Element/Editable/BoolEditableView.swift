//
//  BoolEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/3/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct BoolEditableView: View {
    var title: String
    @ObservedObject var value: ObservableValue<Bool>
    
    var body: some View {
        Toggle(isOn: $value.value) {
            Text(title)
        }
    }
}

//struct BoolEditable_Previews: PreviewProvider {
//    static var previews: some View {
//        BoolEditable()
//    }
//}
