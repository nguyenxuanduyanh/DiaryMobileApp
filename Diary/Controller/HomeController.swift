//
//  HomeController.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/24/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class HomeController: ObservableObject {
    
    @Published var stories: [Story] = [];
    private let db = Firestore.firestore()
    private let userId = Auth.auth().currentUser?.uid
    private var listen: ListenerRegistration? = nil
    let decoder = JSONDecoder()
    
    func logout() {
        do {
            try Auth.auth().signOut();
        } catch {
            
        }
    }
    
    func listenStory() {
        listen =  db.collection("stories").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching document: \(error!)")
                return
            }
            
            print("Current data: \(documents[0].data())")
            var tempStory: [Story] = [];
            for document in documents {
                let data = document.data()
                let uid = data["uid"] as! String
                if uid != self.userId {
                    continue;
                }
                let story = Story(content: data["content"] as! String, created: data["created"] as! Double, image: data["image"] as! String?, uid: data["uid"] as! String)
                tempStory.append(story);
            }
            self.stories = tempStory.sorted(by: { a, b in
                return a.created > b.created
            });
        }
        
    }
    
    func removeListenStory() {
        listen?.remove()
    }
}

struct Story: Identifiable {
    var content: String;
    var created: Double;
    var image: String?;
    var uid: String;
    var id: Double { created }
    
}
