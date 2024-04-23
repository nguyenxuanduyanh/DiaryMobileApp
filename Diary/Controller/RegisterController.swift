//
//  RegisterController.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/17/24.
//

import Foundation

import Combine
import FirebaseAuth

class RegisterController: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    
    func register() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            if (error != nil) {
                self.isLoading = false
            } else {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.username
                changeRequest?.commitChanges { error in
                    self.isLoading = false
                }
            }
        }
    }
}
