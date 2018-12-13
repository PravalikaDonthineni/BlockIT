//
//  LoginViewController.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/11/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func donthaveAccount(_ sender: UIButton) {
         performSegue(withIdentifier: "dontHaveAccountSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.becomeFirstResponder()
    }
    
    @objc func loginButtonTapped(){
        if email.text?.isEmpty ?? true && password.text?.isEmpty ?? true {
            SharedFile.showAlert(msg: "Please enter the email and Password", title: "Text Fields cannot be empty", viewcontroller: self)
        } else {
            performSegue(withIdentifier: "listSegue", sender: nil)
        }
    }
    
}
