//
//  CreateEditDisplayTypes.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/25/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

enum StringDisplayType: String, Codable {
    case text
    case caption
    case quote
    case bookTitle
    case title
}

enum StringCreateDisplayType: String, Codable{
    case textField
    case textView
}

enum StringEditDisplayType: String, Codable{
    case caption
    case quote
    case longText
    case shortText
    
}
///

enum DocumentDisplayType: String, Codable {
    case basic
}

enum DocumentCreateDisplayType: String, Codable{
    case basic
}

enum DocumentEditDisplayType: String, Codable{
    case basic
}
///

enum DateDisplayType: String, Codable {
    case basic
}

enum DateCreateDisplayType: String, Codable {
    case basic
}

enum DateEditDisplayType: String, Codable {
    case full
    case hourAndMinute
}

///

enum DataDisplayType: String, Codable{
    case images
    case scan
    // could have number of allowed images
}

enum DataCreateDisplayType: String, Codable {
    case images
    case scan
}


enum DataEditDisplayType: String, Codable {
    case images
    case scan
}

///
enum ImagesDisplayType: String, Codable{
    case smallScroll
    case mediumScroll
    case largeScroll
}

enum ImagesEditDisplayType: String, Codable {
    case images
}

enum ImagesCreateDisplayType: String, Codable {
    case camera
    case photoLibrary
}

//

enum IntDisplayType: String, Codable {
    case dollars
    case minutes
}

enum IntCreateDisplayType: String, Codable {
    case dollars
    case minutes
}

enum IntEditDisplayType: String, Codable {
    case dollars
    case minutes
}

//
enum PickerDisplayType: String, Codable{
    case basic
    case participants // makes me think we should be like a
    // learner specific one 
    case quoteAttribution
    case conversationAttribution
}

enum PickerCreateDisplayType: String, Codable{
    case basic
}

enum PickerEditDisplayType: String, Codable{
    case basic
}

//
enum PDFDisplayType: String, Codable{
    case basic
}

enum PDFCreateDisplayType: String, Codable{
    case scan
}

enum PDFEditDisplayType: String, Codable{
    case basic
}
///
enum BoolDisplayType: String, Codable{
    case ToDo
}

enum BoolCreateDisplayType: String, Codable{
    case basic 
}

enum BoolEditDisplayType: String, Codable{
    case basic
}
