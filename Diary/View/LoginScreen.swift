//
//  LoginScreen.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/6/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @ObservedObject var loginController = LoginController()
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            
            
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading){
                        HStack(alignment: .center) {
                            Spacer()
                            Image("img_login").resizable().frame(width: 372, height: 308)
                            Spacer()
                        }
                        Spacer().frame(height: 32)
                        HStack {
                            Spacer().frame(width: 32)
                            VStack(alignment: .leading) {
                                Spacer().frame(height: 24)
                                Text("EMAIL").font(.system(size: 24)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Spacer().frame(height: 12)
                                TextField("Email address", text: $loginController.email).font(.system(size: 22)).keyboardType(.emailAddress).autocapitalization(.none)
                                Spacer().frame(height: 24)
                                Text("PASSWORD").font(.system(size: 24)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Spacer().frame(height: 12)
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                                    if !showPassword {
                                        SecureField("Your password", text: $loginController.password).font(.system(size: 22)).textContentType(.none).autocapitalization(.none)
                                    } else {
                                        TextField("Your password", text: $loginController.password).font(.system(size: 22)).autocapitalization(.none)
                                    }
                                    Button(action: {
                                        showPassword = !showPassword
                                    }) {
                                        if !showPassword {
                                            Image(systemName: "eye").frame(width: 32, height:  24).foregroundColor(.black)
                                        } else {
                                            Image(systemName: "eye.slash").frame(width: 32, height:  24).foregroundColor(.black)
                                        }
                                        
                                    }
                                }
                                if !loginController.error.isEmpty {
                                    VStack {
                                        Spacer().frame(height: 20)
                                        Text(loginController.error).foregroundColor(.red).font(.system(size: 14))
                                    }
                                }
                                Spacer().frame(height: 48)
                                
                            }.frame(minWidth: 0,
                                    maxWidth: .infinity,
                                    minHeight: 0,
                                    alignment: .topLeading).padding().background(.white).clipShape( RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            Spacer().frame(width: 32)
                        }
                        Spacer().frame(height: 12)
                        VStack (alignment: .center){
                            Button(action: {
                                loginController.login()
                            }) {
                                HStack {
                                    Text("Login").font(.system(size: 22)).foregroundStyle(Color(.white))
                                }.frame(width: 200)
                            }.padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)).background(Color(hex: "F27171")).cornerRadius(24)
                            
                        }.frame(minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0).padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)).offset(y: -40)
                        Spacer().frame(height: 8)
                        HStack() {
                            Spacer()
                            NavigationLink {
                                RegisterScreen()
                            } label: {
                                Text("Signup").foregroundColor(.white).font(.system(size: 18)).underline()
                            }
                            
                            Spacer()
                        }
                        Spacer()
                        HStack() {
                            Spacer()
                            NavigationLink {
                                ForgotPasswordScreen()
                            } label: {
                                Text("Forgot Password?").foregroundColor(.white).font(.system(size: 18)).underline()
                            }
                            Spacer()
                        }
                        Spacer().frame(height: 24)
                        
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "F17171"), Color(hex: "375B64")]), startPoint: .top, endPoint: .bottom))            .shadow(color: .black, radius: 5, x: 0, y: 5).scrollIndicators(.hidden)
            }
            if loginController.isLoading {
                AppLoading()
            }
        }
    }
}

#Preview {
    LoginScreen()
}
