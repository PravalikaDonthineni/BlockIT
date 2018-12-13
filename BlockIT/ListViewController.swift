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
   
    var domainNames: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domainNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = domainNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = name.value(forKeyPath: "domain") as? String
        return cell
    }
    
    @IBAction func domainSubmit(_ sender: UIButton) {
        guard let domain = enterDomain.text else {
            return
        }
        save(domain)
        tableView.reloadData()
        enterDomain?.text = ""
    }
    
    func save(_ name: String) {
        let managedContext = PersistenceService.context
        guard let entity = NSEntityDescription.entity(forEntityName: "WebsiteNames",
                                                      in: managedContext) else {return}
        
        let domain = NSManagedObject(entity: entity, insertInto: managedContext)
        domain.setValue(enterDomain?.text, forKeyPath: "domain")
        do {
            try managedContext.save()
            domainNames.append(domain)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch() {
        let managedContext = PersistenceService.context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WebsiteNames")
        do {
             let domainnames = try managedContext.fetch(fetchRequest)
             self.domainNames = domainnames
             self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
