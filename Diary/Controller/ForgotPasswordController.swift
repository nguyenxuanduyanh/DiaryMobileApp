//
//  ForgotPasswordController.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/24/24.
//

import Foundation
import FirebaseAuth
import SwiftUI

class ForgotPasswordController: ObservableObject {
    @Published var email = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isShowAlert = false

    func getPassword() {
        if (!isValidEmail(email)) {
            errorMessage = "Email is invalid"
            return
        }
        isLoading = true
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if (error != nil) {
                self.errorMessage = error?.localizedDescription ?? "Something was wrong"
            } else {
                self.isShowAlert = true
            }
            self.isLoading = false
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
            let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: [.caseInsensitive])
            return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil
        }
    
    func changeStatusAlert() {
        isShowAlert = !isShowAlert
    }
}
