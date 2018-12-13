//
//  LoginViewController.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/11/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.becomeFirstResponder()
    }
    
    @IBAction func donthaveAccount(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        loginButtonTapped()
    }
    
    @objc func loginButtonTapped(){
        if email.text?.isEmpty ?? true && password.text?.isEmpty ?? true {
            UIAlertController.getAlertView("Error", message: "Text fields cannot be empty. Please enter the email and password").show(self)
        } else {
            if let email = email.text, let pwd = password.text {
                if let object = UserProfileCache.get(cacheKey: email + pwd) {
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                        vc.user = object
                        let navVc = UINavigationController(rootViewController: vc)
                        self.present(navVc, animated: true, completion: nil)
                    }
                } else {
                    UIAlertController.getAlertView("Error", message: "Please enter the correct username & password.").show(self)
                }
            }
        }
    }
    
}
