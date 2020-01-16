//
//  Templates.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/8/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import Foundation

func createTemplates(){
    makePhotoPickerDocument()
    makeTextTemplate()
    makeQuoteTemplate()
    makeScanTemplate()
    makeReadingTemplate()
    makeQuestionTemplate()
    makeToDoTemplate()
    makeActivityReflectionTemplate()
    AppDelegate.shared.saveContext()
}
