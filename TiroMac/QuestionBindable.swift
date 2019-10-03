//
//  QuestionBindable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/31/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import Combine

class QuestionBindable : ObservableObject {
    
    @Published var question_text : String
    @Published var asker : Learner?
    @Published var answer_text: String

    
    init(question_text: String, asker: Learner?, answer_text: String?){
        self.question_text = question_text
        self.asker = asker
        self.answer_text = answer_text ?? ""
    }
}
