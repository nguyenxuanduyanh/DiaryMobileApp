//
//  AppLoading.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/24/24.
//

import SwiftUI

struct AppLoading: View {
    var body: some View {
        VStack {
            ProgressView()
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).background(.black.opacity(0.2))
    }
}

#Preview {
    AppLoading()
}
