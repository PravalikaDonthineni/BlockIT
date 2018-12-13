//
//  UIAlertController+Extension.swift
//  BlockIT
//
//  Created by Gaurav Chintakindi on 12/13/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func getAlertView(_ title: String, message: String?, cancelButtonTitle: String? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: cancelButtonTitle ?? "Ok", style: .cancel, handler: cancelHandler)
        alertVc.addAction(okAction)
        return alertVc
    }

    func show(_ presentingVc: UIViewController?) {
        if let vc = presentingVc {
            vc.present(self, animated: true, completion: nil)
        }
    }
}
