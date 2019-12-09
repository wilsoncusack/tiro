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
    case basic
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
    case images
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
