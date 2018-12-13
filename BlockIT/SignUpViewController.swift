//
//  SignUpViewController.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/11/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBAction func uploadImage(_ sender: UIButton) {
        
    }
    @IBAction func submitButton(_ sender: UIButton) {
        if email.text?.isEmpty ?? true && password.text?.isEmpty ?? true {
            SharedFile.showAlert(msg: "Please enter the email and Password", title: "Text Fields cannot be empty", viewcontroller: self)
        } else {
//            let newUser = UserDetails(context: PersistenceService.context)
//            newUser.setValue(email.text, forKey: "email")
//            newUser.setValue(password.text, forKey: "password")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = #imageLiteral(resourceName: "profilepic")
        email.becomeFirstResponder()
    }

}
