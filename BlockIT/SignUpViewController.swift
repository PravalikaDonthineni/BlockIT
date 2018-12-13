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
            guard let email = email.text, let password = password.text else {
                return
            }
            save(emailValue: email, passwordValue: password)
            performSegue(withIdentifier: "sinupPushLoginSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.image = #imageLiteral(resourceName: "profilepic")
        email.becomeFirstResponder()
    }
    
    func save(emailValue: String, passwordValue : String) {
        let managedContext = PersistenceService.context
        guard let entity = NSEntityDescription.entity(forEntityName: "UserDetails",
                                                      in: managedContext) else {return}
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(email.text, forKeyPath: "email")
        user.setValue(password.text, forKeyPath: "password")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
