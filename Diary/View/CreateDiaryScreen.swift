//
//  CreateDiaryScreen.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/28/24.
//

import SwiftUI
import PhotosUI

struct CreateDiaryScreen: View {
    
    @ObservedObject private var createDiaryController = CreateDiaryController()
    // copilot
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    ZStack {
                        Text("Create Diary").foregroundColor(.white).font(.system(size: 28)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        HStack(alignment: .bottom) {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "arrowshape.backward").resizable().frame(width: 24, height: 24).foregroundColor(.white)
                            }
                            Spacer()
                            Button(action: {
                                // https://www.hackingwithswift.com/quick-start/concurrency/how-to-fix-the-error-async-call-in-a-function-that-does-not-support-concurrency
                                DispatchQueue.main.async {
                                    createDiaryController.uploadDiary()
                                }
                            }) {
                                Text("Save").font(.system(size: 20)).foregroundColor(.white).fontWeight(.bold)
                            }
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity,  alignment: .leading)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0).padding(EdgeInsets(top: 8, leading: 16, bottom: 12, trailing: 16)).background(Color(hex: "445D67"))
                }
                VStack {
                    VStack {
                        ZStack {
                            ScrollView {
                                Spacer().frame(height: 18)
                                PhotosPicker(selection: $createDiaryController.imageSelection, matching: .images,
                                             photoLibrary: .shared())  {
                                    switch createDiaryController.imageState {
                                    case .success(let image):
                                        image.resizable().frame(width: 180, height: 120)
                                    case .loading:
                                        ProgressView()
                                    case .empty:
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                    case .failure:
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)
                                    case .none:
                                        Image(systemName: "photo.on.rectangle.angled").resizable().frame(width: 40, height: 40).foregroundColor(.blue)
                                    }
                                }
                                // https://developer.apple.com/documentation/swiftui/view/linelimit(_:)-4hzfa
                                TextField("Your story", text: $createDiaryController.content, axis: .vertical).padding().multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).lineLimit(1...20).font(.system(size: 18)).foregroundColor(.black).frame(minHeight: 0, maxHeight: .infinity)
                            }
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding()
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(.white).cornerRadius(36)
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            }.background(LinearGradient(gradient: Gradient(colors: [Color(hex: "ED7071"), Color(hex: "545F68")]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.keyboard)
            if createDiaryController.isLoading {
                AppLoading()
            }
            // copilot
        }.onChange(of: createDiaryController.isComplete) {
            if (createDiaryController.isComplete) {
                dismiss()
            }
        }
    }
    
}

#Preview {
    CreateDiaryScreen()
}
