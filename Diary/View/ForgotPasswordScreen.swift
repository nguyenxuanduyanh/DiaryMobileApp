//
//  ForgotPasswordScreen.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/17/24.
//

import SwiftUI

struct ForgotPassword: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var email = ""
    var body: some View {
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
                            TextField("Email address", text: $email).font(.system(size: 22))
                            Spacer().frame(height: 48)
                            
                        }.frame(minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                alignment: .topLeading).padding().background(.white).clipShape( RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                        Spacer().frame(width: 32)
                    }
                    Spacer().frame(height: 12)
                    VStack (alignment: .center){
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            HStack {
                                Text("Get password").font(.system(size: 22)).foregroundStyle(Color(.white))
                            }.frame(width: 200)
                        }.padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)).background(Color(hex: "F27171")).cornerRadius(24)
                        
                    }.frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0).padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)).offset(y: -40)
                    Spacer()
                    HStack() {
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Login").foregroundColor(.white).font(.system(size: 18)).underline()
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
    }
}

#Preview {
    ForgotPassword()
}
