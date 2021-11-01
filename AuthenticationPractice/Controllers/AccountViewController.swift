//
//  AccountViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 29/10/21.
//

import UIKit
import FirebaseStorage

class AccountViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var delegate: MenuDelegate?
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var uploadButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    let defaultImage: UIImage = UIImage(systemName: "person")!
    
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureScreen()
        getImage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func uploadButtonPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        //        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        self.profileImage.image = self.defaultImage
        UserDefaults.standard.set("", forKey: "url")
        removeButton.isHidden = true
    }
    
    func getImage() {
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String else { return }
        
        NetworkManager.shared.downloadImage(fromURL: urlString) { image in
            guard let image = image else {
                self.profileImage.image = self.defaultImage
                return
            }
            DispatchQueue.main.async {
                self.profileImage.image = image
            }
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.profileImage.image = image
        
        guard let imageData = image.pngData() else {
            
            return
        }
        
        storage.child("profile/file.png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                return
            }
            
            self.storage.child("profile/file.png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                let urlString = url.absoluteString
                
                DispatchQueue.main.async {
                    
                    self.removeButton.isHidden = false
                }
                
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "url")
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true,completion: nil)
    }
    
    func configureNavigation() {
        navigationItem.title = menuItemConstants.account
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: imageConstants.menu), style: .plain, target: self, action: #selector(handleMenu))
    }
    
    @objc func handleMenu() {
        delegate?.menuHandler()
    }
}
