//
//  AuthorizationView.swift
//  ChessApp
//
//  Created by maksim.surkov on 25.09.2021.
//

import Foundation
import SwiftUI

struct AuthorizationView: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var password = ""
    @State var passwordAgaib = ""
    var body: some View {
        
        VStack(alignment: .center) {
            Spacer()
            VStack {
                //Spacer()
                Text("Авторизация")
                    .font(.title)
            
            } .padding([.bottom], 24)
            VStack {
               
                TextField("Логин", text: $firstName)
                    .padding()
                    //.frame(height: 55)
                    .background(Color(red: 240/255, green: 241/255, blue: 245/255))
                    .cornerRadius(16)
                .padding([.leading, .trailing], 24)
                
                SecureField("Пароль", text: $password)
                    .padding()
                    //.frame(height: 55)
                    .background(Color(red: 240/255, green: 241/255, blue: 245/255))
                    .cornerRadius(16)
                    .padding([.leading, .trailing], 24)
                

                Button {
                    print("suka swiftui")
                } label: {
                    Text("Войти")
                        .padding([.top, .bottom], 25)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 24)
                }
                Button {
                    
                } label: {
                    Text("Забыли пароль ?")
                        .padding([.top, .bottom], 25)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        
                        .cornerRadius(8)
                        .padding([.leading, .trailing], 24)
                }
                

            }
            Spacer()
        }
//        NavigationView {
//            VStack {
//                Form {
//                    Section {
//                        TextField("First name", text: $firstName)
//                        TextField("Last name", text: $lastName)
//                    }
//                    Section(footer: Text("some")) {
//                        SecureField("Create password", text: $password)
//                        SecureField("", text: $passwordAgaib)
//                    }
//                }
//            }.navigationTitle("Authorization")
//        }
    }
}

struct AuthorizationView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            AuthorizationView()
        }
    }
}

