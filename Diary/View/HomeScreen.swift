//
//  HomeScreen.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/17/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var homeController = HomeController()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ZStack {
                    Text("My Diary").foregroundColor(.white).font(.system(size: 28)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    HStack(alignment: .bottom) {
                        Spacer()
                        Button(action: {
                            homeController.logout()
                        }) {
                            Image(systemName: "rectangle.portrait.and.arrow.right").resizable().frame(width: 24, height: 24).foregroundColor(.white)
                        }
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                    
                    
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0).padding(EdgeInsets(top: 8, leading: 16, bottom: 12, trailing: 16)).background(Color(hex: "445D67"))
            }
            VStack {
                VStack {
                    ZStack(alignment: .bottomLeading) {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                    Image(systemName: "plus").resizable().frame(width: 56, height: 56).foregroundColor(.white)
                                }.background(
                                    Circle().fill(Color(hex: "545F68")).frame(width: 80, height: 80)
                                )
                            }
                        }
                        
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 24))
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(.white).cornerRadius(36)
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }.background(LinearGradient(gradient: Gradient(colors: [Color(hex: "ED7071"), Color(hex: "545F68")]), startPoint: .top, endPoint: .bottom))
        
    }
}

#Preview {
    HomeScreen()
}
