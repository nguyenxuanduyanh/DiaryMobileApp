//
//  CreateDiaryController.swift
//  Diary
//
//  Created by Duy Anh Nguyễn Xuân on 4/28/24.
//

import Foundation
import PhotosUI
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import Firebase
import FirebaseStorage

enum TransferError: Error {
    case importFailed
}

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

class CreateDiaryController: ObservableObject {
    @Published var content = ""
    @Published var isLoading = false
    @Published var isComplete = false
    private let db = Firestore.firestore()
    private var imageUpload: UIImage? = nil
    private var imageUrl: URL? = nil
    
    private let storage = Storage.storage()
    @Published var imageState: ImageState? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
                
            } else {
                imageState = .empty
            }
        }
    }
    
    // https://firebase.google.com/docs/firestore/manage-data/add-data#swift
    func uploadDiary() {
        isLoading = true
        let uid = Auth.auth().currentUser?.uid
        let date = Date()
        let milliseconds = Int(date.timeIntervalSince1970 * 1000)
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("images/image-story-\(milliseconds).jpg")
        print("image url \(imageUrl)")
        if (imageUrl != nil) {
            
            _ = imagesRef.putFile(from: imageUrl!, metadata: nil) { metadata, error in
                guard metadata != nil else {
                    // Uh-oh, an error occurred!
                    print("error 123 \(error)")
                    self.isLoading = false
                    return
                }
                print("upload image success")
                imagesRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        self.isLoading = false
                        print("error 1234 \(error)")
                        return
                    }
                    print("download url \(downloadURL)")
                    let docData: [String: Any] = [
                        "created": milliseconds,
                        "content": self.content,
                        "uid": uid ?? NSNull(),
                        "image": downloadURL.path()
                    ]
                    self.db.collection("stories").document().setData(docData) { result in
                        
                        self.isComplete = true
                        self.isLoading = false
                    }
                }
            }
        } else {
            let docData: [String: Any] = [
                "created": milliseconds,
                "content": content,
                "uid": uid ?? NSNull(),
            ]
            db.collection("stories").document().setData(docData) {result in
                self.isComplete = true
                self.isLoading = false
                
            }
            
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ImageUpload.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let imageUpload?):
                    print("image str \(imageUpload.uiImage)")
                    self.imageState = .success(imageUpload.image)
                    // https://www.hackingwithswift.com/forums/swiftui/saving-and-displaying-images-using-the-image-picker/19338
                    self.imageUpload = imageUpload.uiImage
                    let name = String(Date.timeIntervalSinceReferenceDate)
                    
                    let fm = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    
                    if let image = imageUpload.uiImage.pngData() {
                        let imageName = name.replacingOccurrences(of: ".", with: "-")
                        let url = fm.appendingPathComponent(imageName)
                        do {
                            try image.write(to: url)
                            self.imageUrl = url
                        } catch {
                            
                        }
                    }
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    /// from: https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory
    private func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}


struct ImageUpload: Transferable {
    let image: Image
    let uiImage: UIImage
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
#if canImport(AppKit)
            guard let nsImage = NSImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(nsImage: nsImage)
            return ProfileImage(image: image)
#elseif canImport(UIKit)
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            
            return ImageUpload(image: image, uiImage: uiImage)
#else
            throw TransferError.importFailed
#endif
        }
    }
}

