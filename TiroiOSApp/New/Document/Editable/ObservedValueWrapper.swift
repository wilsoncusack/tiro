//
//  ObservedValueWrapper.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import Combine

class ObservableValue<AValue>: ObservableObject where AValue: Equatable {
    @Published var value: AValue
    var listener: AnyCancellable?
    
    init(value: AValue, save: @escaping (AValue) -> Void){
        self.value = value
        self.listener = self.$value
        .removeDuplicates()
            .sink(receiveValue: { (value) in
            save(value)
        })
    }
    
    deinit{
        self.listener?.cancel()
    }
}
