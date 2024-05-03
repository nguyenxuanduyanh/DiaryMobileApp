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
        NavigationStack {
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
                        ZStack(alignment: .bottom) {
                            ScrollView {
                                LazyVStack {
                                    ForEach(homeController.stories) { story in
                                        NavigationLink {
                                            DetailScreen(story: story).navigationBarBackButtonHidden()
                                        } label: {
                                            HStack {
                                                Text(story.content).lineLimit(1).font(.system(size: 16)).foregroundColor(.black)
                                                Spacer()
                                                Text(Date(timeIntervalSince1970: story.created / 1000).formatted(date: .numeric, time: .omitted)).font(.system(size: 16))
                                            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding()
                                        }
                                        
                                    }
                                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
                            }.padding(.vertical)
                            
                                VStack {
                                    HStack {
                                        Spacer()
                                        NavigationLink {
                                            CreateDiaryScreen().navigationBarBackButtonHidden()
                                        } label: {
                                        VStack {
                                            Image(systemName: "plus").resizable().frame(width: 56, height: 56).foregroundColor(.white)
                                        }.background(
                                            Circle().fill(Color(hex: "545F68")).frame(width: 80, height: 80)
                                        )
                                        }.padding(.horizontal).padding(.vertical)
                                }.padding()
                            }
                        }
                    }
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(.white).cornerRadius(36).padding(.horizontal)
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(.bottom, 12).background(LinearGradient(gradient: Gradient(colors: [Color(hex: "ED7071"), Color(hex: "545F68")]), startPoint: .top, endPoint: .bottom))
        }.onAppear(perform: {
            homeController.listenStory()
        }).onDisappear(perform: {
            homeController.removeListenStory()
        })
    }
}

#Preview {
    HomeScreen()
}
