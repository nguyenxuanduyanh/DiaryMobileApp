//
//  LoginController.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/17/24.
//

import Foundation
import Combine

import FirebaseAuth

class LoginController: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    
    func register() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error  in
            self.isLoading = false
        }
    }
}
