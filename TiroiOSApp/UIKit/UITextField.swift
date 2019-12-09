//
//  UITextField.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/5/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct UITextViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
   // var onChange: (String) -> Void
    @Binding var isFirstResponder: Bool
    let textView = UITextView()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        //let textView = UITextView()
        
        textView.backgroundColor = nil
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textContainerInset = .zero
        
        if(text.isEmpty){
            textView.text = "Type something..."
            textView.textColor = UIColor.gray
        }
        
        
        if(isFirstResponder){
            textView.becomeFirstResponder()
        }
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if(isFirstResponder == false){
            textView.resignFirstResponder()
        }
//        onChange(text)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var field: UITextViewRepresentable
        
        init(_ field: UITextViewRepresentable) {
            self.field = field
          
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            self.field.isFirstResponder = true
            if(textView.text == "Type something..."){
                
                textView.text = ""
                textView.textColor = UIColor.label
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            field.text = textView.text
        }
        
       
        
        
    }
}
