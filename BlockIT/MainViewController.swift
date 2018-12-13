//
//  ViewController.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/7/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBAction func loginButton(_ sender: UIButton) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    @IBAction func Signup(_ sender: UIButton) {
        performSegue(withIdentifier: "SignupSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = #imageLiteral(resourceName: "blockit")
    }
    
}

