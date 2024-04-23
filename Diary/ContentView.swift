//
//  ContentView.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authController = AuthController()
    var body: some View {
        if authController.session != nil {
            HomeScreen()
        } else {
            LoginScreen()
        }
    }
}
#Preview {
    ContentView()
}
