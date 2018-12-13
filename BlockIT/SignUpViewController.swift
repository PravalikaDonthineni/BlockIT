//
//  SignUpViewController.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/11/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func uploadImage(_ sender: UIButton) {
        
        //code for image picker
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        
        //code for alert box
        let actionSheet = UIAlertController(title : "Photo Source", message : "Choose the Source", preferredStyle: . actionSheet)
        
        //camera
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController,  animated: true,completion: nil)
            }
            else{
                let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
                
                let okAction = UIAlertAction.init(title: "Alright", style: .default, handler: {(alert: UIAlertAction!) in
                })
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }))
        
        //photo library
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePickerController,  animated: true,completion: nil)
        }))
        
        //cancel option
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(actionSheet,animated: true,completion: nil)
        
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        if email.text?.isEmpty ?? true && password.text?.isEmpty ?? true {
            SharedFile.showAlert(msg: "Please enter the email and Password", title: "Text Fields cannot be empty", viewcontroller: self)
        } else {
//            guard let email = email.text, let password = password.text else {
//                return
//            }
            performSegue(withIdentifier: "sinupPushLoginSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = #imageLiteral(resourceName: "profilepic")
        email.becomeFirstResponder()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //getting the uploaded image as UIImage
        guard let importImage = info[.originalImage] as? UIImage else {
            return
        }
        profilePicture?.image = importImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
