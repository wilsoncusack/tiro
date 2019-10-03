////
////  Store.swift
////  TiroiOSApp
////
////  Created by Wilson Cusack on 9/19/19.
////  Copyright © 2019 Wilson Cusack. All rights reserved.
////
//
//import Combine
//
//final class Store<Value, Action>: ObservableObject {
//    let reducer: (Value, Action) -> Value
//    @Published var value: Value
//    
//    init(initialValue: Value, reducer: @escaping (Value, Action) -> Value){
//        self.value = initialValue
//        self.reducer = reducer
//    }
//    
//    func send(_ action: Action){
//        self.value = self.reducer(self.value, action)
//    }
//}
