//
//  AccountViewController.swift
//  AuthenticationPractice
//
//  Created by Swasthik K S on 29/10/21.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var delegate: MenuDelegate?
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var uploadButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureScreen()
        getImage()
        configureUI()
        getData()
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
        self.profileImage.image = imageConstants.defaultProfile
        UserDefaults.standard.set("", forKey: "url")
        removeButton.isHidden = true
    }
    
    func configureUI() {
        profileImage.layer.cornerRadius = 20
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 5
    }
    
    func getData() {
        NetworkManager.shared.getUser { result in
            switch result {
                
            case .success(let data):
                let username = data["username"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                
                self.usernameLabel.text = "Username : \(username)"
                self.uidLabel.text = "UID : \(uid)"
            case .failure(let error):
                self.showAlert(title: "Failed to load user data", message: error.localizedDescription)
            }
        }
    }
    
    func getImage() {
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String else { return }
        
        NetworkManager.shared.downloadImage(fromURL: urlString) { image in
            guard let image = image else {
                self.profileImage.image = imageConstants.defaultProfile
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
        self.removeButton.isHidden = false
        
        ImageUploader.uploadImage(image: image)
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
