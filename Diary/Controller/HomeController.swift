//
//  HomeController.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/24/24.
//

import Foundation
import FirebaseAuth


class HomeController: ObservableObject {
    
    func logout() {
        do {
            try Auth.auth().signOut();
        } catch {
            
        }
    }
}
