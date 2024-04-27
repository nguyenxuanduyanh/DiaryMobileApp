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
    @Published var error = ""
    
    func register() {
        if (username.count < 6) {
            error = "Username must be 6 characters or more"
            return
        } else if (!isValidEmail(email)) {
            error = "Email is invalid"
            return
        } else if (password.count < 6 || password.count > 32) {
            error = "Password ranges from 6 to 32 characters"
            return
        } else if (password != confirmPassword) {
            error = "The re-entered password does not match"
            return
        }
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
    
    func isValidEmail(_ email: String) -> Bool {
            let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
        }
}
