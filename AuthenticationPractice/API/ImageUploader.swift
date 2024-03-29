//
//  ImageUploader.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 02/11/21.
//

import Foundation
import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage) {
        
        let storage = Storage.storage().reference()
        
        guard let imageData = image.pngData() else {
            return
        }
        
        storage.child("profile/file.png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                return
            }
            
            storage.child("profile/file.png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            }
        }
    }
    
}

