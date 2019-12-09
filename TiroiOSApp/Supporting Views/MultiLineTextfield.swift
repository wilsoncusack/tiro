//
//  MultiLineTextfield.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/22/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

import SwiftUI
import UIKit

public struct MultiLineTextfield: View {
    @State var text : String? = "testing"
    @State var closeKeyboard : Bool = false
    
    public var body: some View {
        VStack{
        Button(action: {self.closeKeyboard.toggle()}){
            Text("close")
        }
            TextEditor(text: $text, closeKeyboard: $closeKeyboard)
                .onTapGesture {
                    self.closeKeyboard = false
            }
        }
    }
}

public struct TextEditor: View {
    @Binding public var text: String?
    @Binding public var closeKeyboard : Bool
    
    public var body: some View {
        TextField_UI(text: $text, closeKeyboard: $closeKeyboard)
    }
}

struct TextField_UI : UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String?
    @Binding var closeKeyboard: Bool
    var onEditingChanged: ((String) -> Void)?
    var onCommit: (() -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, closeKeyboard)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = nil
        textView.text = text ?? ""
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textContainerInset = .zero
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = text ?? ""
        if(closeKeyboard == true){
            textView.resignFirstResponder()
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var field: TextField_UI
        var myVal : Bool
        
        init(_ field: TextField_UI, _ closeKeyboard: Bool) {
            self.field = field
            self.myVal = closeKeyboard
        }
        
        func textViewDidChange(_ textView: UITextView) {
            field.text = textView.text
        }
        
        
    }
}

struct MultiLineTextfield_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineTextfield()
    }
}
