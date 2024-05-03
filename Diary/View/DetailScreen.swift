//
//  DetailScreen.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 5/3/24.
//

import SwiftUI

struct DetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    var story: Story;

    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    ZStack {
                        Text("Detail Diary").foregroundColor(.white).font(.system(size: 28)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        HStack(alignment: .bottom) {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "arrowshape.backward").resizable().frame(width: 24, height: 24).foregroundColor(.white)
                            }
                            
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity,  alignment: .leading)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0).padding(EdgeInsets(top: 8, leading: 16, bottom: 12, trailing: 16)).background(Color(hex: "445D67"))
                }
                VStack {
                    VStack {
                        ZStack {
                            ScrollView {
                                VStack {
                                    Text(Date(timeIntervalSince1970:  story.created / 1000).formatted(date: .numeric, time: .shortened)).lineLimit(1...20).font(.system(size: 18)).foregroundColor(.black).font(.system(size: 22)).frame(minHeight: 0, maxHeight: .infinity)
                                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing).padding(.vertical)
                                if story.image != nil {
                                    Spacer().frame(height: 18)
                                    AsyncImage(url: URL(string: story.image!)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 180, height: 120)
                                }
                                Spacer().frame(height: 18)
                                VStack(alignment: .leading) {
                                    Text(story.content).lineLimit(1...20).font(.system(size: 18)).foregroundColor(.black).font(.system(size: 22)).frame(minHeight: 0, maxHeight: .infinity)
                                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.vertical)
                                
                            }
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding()
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(.white).cornerRadius(36)
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            }.background(LinearGradient(gradient: Gradient(colors: [Color(hex: "ED7071"), Color(hex: "545F68")]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.keyboard)
            // copilot
        }
    }
}

#Preview {
    DetailScreen(story: Story(content: "1", created: 100000, uid: "123" ))
}
