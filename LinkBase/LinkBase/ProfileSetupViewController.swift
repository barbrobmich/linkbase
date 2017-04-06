//
//  ProfileSetupViewController.swift
//  LinkBase
//
//  Created by Barbara Ristau on 4/1/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ProfileSetupViewController: UIViewController {

    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weirdFactTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var currentUser: User!
    var firstName: String!
    var lastName: String!
    var weirdFact: String!
    var image: UIImage!
    var changedProfileImage: Bool?
    var onPhotoTap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        
        currentUser = User.current()
        print("Current user: \(currentUser.username!)")
        changedProfileImage = false
        
        firstName = currentUser.object(forKey: "firstname") as? String
        lastName = currentUser.object(forKey: "lastname") as? String
        weirdFact = currentUser.object(forKey: "weird_fact") as? String
        
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        
        emailTextField.text = currentUser.email!
        
        getCurrentUserImage()
        onPhotoTap = UITapGestureRecognizer(target: self, action: #selector(self.getPhoto(_:)))
        profileImageView.addGestureRecognizer(onPhotoTap)
        profileImageView.isUserInteractionEnabled = true 
    }
    
    
    // MARK: - PROFILE IMAGE RELATED METHODS
    
    func getCurrentUserImage() {
        
        let myImage = PFImageView()
        
        if currentUser["profile_image"] != nil {
            
//             weirdFact = currentUser.object(forKey: "weird_fact") as? String
         //   myImage.file = currentUser["profile_image"] as? PFFile
            myImage.file = currentUser.object(forKey: "profile_image") as? PFFile
            myImage.loadInBackground()
        } else {
            myImage.image = UIImage(named: "profilePlaceholder")!
        }
        
        
        profileImageView.image = myImage.image
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 15
        
    }
    
    
    func getPhoto(_ sender: UITapGestureRecognizer){
        print("Getting the photo")
        pickPhoto()
    }
    
    func show(image: UIImage) {
        
        profileImageView.image = image
        profileImageView.frame = CGRect(x: 70, y: 50, width: 64, height: 64)
        // adjust x and y coordinates, can these be set in autolayout
        
    }
  
    func postProfileImageToParse() {
        
        User.saveProfileImage(image: profileImageView.image) { (success: Bool, error: Error?) -> Void in
            
            if success {
                print("Successful Post to Parse")
                }
            else {
                print("Can't post to parse")
            }
        }
    }


    @IBAction func onSave(_ sender: UIButton) {
    print("tapped on Save")
        
        // need to change this to update / just regular save 
        
//        postProfileImageToParse()
//        
//        User.updateProfileData(fname: firstNameTextField.text!, lname: lastNameTextField.text!, email: emailTextField.text!, weirdFact: weirdFactTextView.text) { (success: Bool, error: Error?) -> Void in
//            
//            if success {
//                print("Successful Post to Parse")
//                // segue to next section
//            }
//            else {
//                print("Can't post to parse")
//            }
//        }
    }
    

    
    
    @IBAction func onLogout(_ sender: UIButton) {
        print("Logging Out")
        User.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogout), object: nil)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddAffiliations" {
            print("Going to add Affiliations")
     
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! AddAffiliationsViewController
            targetController.navigationItem.title = "Add Affiliations"
        }
        
    }
    

}


extension ProfileSetupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func takePhotoWithCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = info[UIImagePickerControllerEditedImage] as? UIImage
        print("did pick the image")
        
        if let theImage = image{
            print("Going to show the image")
            changedProfileImage = true
            show(image: theImage)
        }
        
        //tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        }
        else {
            choosePhotoFromLibrary()
        }
    }
    
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {_ in self.takePhotoWithCamera() })
        alertController.addAction(takePhotoAction)
        
        let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: {_ in self.choosePhotoFromLibrary() })
        
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

