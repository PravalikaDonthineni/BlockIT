//
//  ListViewController.swift
//  BlockIT
//
//  Created by Pravalika Donthineni on 12/11/18.
//  Copyright © 2018 Pravalika Donthineni. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var enterDomain: UITextField!
   
    var domainNames: [String] = []
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user, let urls = user.urls, urls.count > 0 {
            for i in urls {
                domainNames.append(i)
            }
        }
        
        // Long Press Gesture for deleting the row
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ListViewController.longPressToDelete))
        tableView.addGestureRecognizer(longPress)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domainNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = domainNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let domainName = domainNames[indexPath.row]
        showBrowserOptions(url: domainName)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    // present an action sheet with browser options and navigate to web browser
    func showBrowserOptions(url: String) {
        
        let urlForSafari = "https://" + url
        guard let safariURL = URL(string: urlForSafari) else { return }
        
        let urlForChrome = "googlechrome://" + url
        guard let chromeURL = URL(string: urlForChrome) else { return }
        
        
        let actionSheet = UIAlertController(title: "Select Browser", message: "", preferredStyle: .actionSheet)
        
        if UIApplication.shared.canOpenURL(safariURL) {
            actionSheet.addAction(UIAlertAction(title: "Open with Safari", style: .default, handler: { (action) in
                UIApplication.shared.open(safariURL)
            }))
        }
        
        if UIApplication.shared.canOpenURL(chromeURL) {
            actionSheet.addAction(UIAlertAction(title: "Open with Chrome", style: .default, handler: { (action) in
                UIAlertController.getAlertView("Error", message: "This website is blocked.").show(self)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    @IBAction func domainSubmit(_ sender: UIButton) {
        self.view.endEditing(true)
        if let urlName = enterDomain.text, var loggedInUser = user {
            loggedInUser.urls?.append(urlName)
            domainNames.append(urlName)
            UserProfileCache.save(loggedInUser)
            tableView.reloadData()
            enterDomain?.text = ""
        }
    }
    
    // delete the url from the list on long press
    @objc func longPressToDelete(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.tableView)
            if let indexpath = self.tableView.indexPathForRow(at: touchPoint) {
                let alert = UIAlertController(title: "Please Confirm", message: "Are you sure you want to delete this url from the list?", preferredStyle: .alert)
                let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
                let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                    if var loggedInUser = self.user {
                        loggedInUser.urls?.remove(at: indexpath.row)
                        self.domainNames.remove(at: indexpath.row)
                        UserProfileCache.save(loggedInUser)
                        self.tableView.reloadData()
                    }
                }
                alert.addAction(noAction)
                alert.addAction(yesAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
