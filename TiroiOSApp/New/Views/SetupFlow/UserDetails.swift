//
//  UserDetails.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI

struct UserDetails : View {
    @ObservedObject var store: Store<AppState, AppAction>
    
    @State var first_name = ""
    @State var last_name = ""
    
    var body: some View {
        
        
        VStack {
            VStack{
                Text("Enter your profile information")
                Spacer()
                TextField("First name", text: $first_name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Last name", text: $last_name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: 120)
                .padding(.top, 50)
            Spacer()
            if(first_name == "" || last_name == ""){
                Text("Next")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.95)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .padding(.bottom, 15)
            } else {
               
                
                Button(action: {
                    self.store.send(.user(.create(birthday: nil, image: nil, firstName: self.first_name, lastName: self.last_name)))
//                    self.mainEnv.createUser(first_name: self.first_name, last_name: self.last_name)
//                    self.mainEnv.setupShowUserCreation = false
                }){
                    Text("Next")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.95)
                        .background(Color.blue)
                        .cornerRadius(8)
                }.padding(.bottom, 15)
            }
        }.frame(width: UIScreen.main.bounds.width * 0.8)
            .navigationBarTitle("Profile Info", displayMode: .inline)
        
        
    }
}

#if DEBUG
//struct UserDetails_Previews : PreviewProvider {
//    static var previews: some View {
//        UserDetails().environmentObject(MainEnvObj())
//    }
//}
#endif
