//
//  SharedFile.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/11/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit

class SharedFile: NSObject {
    static func showAlert( msg : String, title : String, viewcontroller : UIViewController) {
        let alertcontroller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let defualtAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertcontroller.addAction(defualtAction)
        viewcontroller.present(alertcontroller,animated: true, completion: nil)
    }

}
