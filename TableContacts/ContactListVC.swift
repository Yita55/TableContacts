//
//  ViewController.swift
//  TableContacts
//
//  Created by James Rochabrun on 4/21/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class ContactListVC: UITableViewController {
    
 
    let dataSource = ContactsDataSource(sectionedData: ContactsSource.sectionContacts, sectionTitles: ContactsSource.sortedUniqueFirstLettersArray)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = dataSource.object(at: indexPath)
                guard let contactDetailVC = segue.destination as? ContactDetailVC  else { return }
                contactDetailVC.contact = contact
                contactDetailVC.delegate = self
            }
        }
    }
}

extension ContactListVC:  ContactDetailVCDelegate {
    
    func didMarkAsFavoriteContact(_ contact: Contact) {
        
        guard let indexPath = dataSource.indexPath(for: contact) else { return }
        
        var favoriteContaxt = dataSource.object(at: indexPath) //contact
        favoriteContaxt.isFavorite = true
        dataSource.updateContact(favoriteContaxt, at: indexPath)
        tableView.reloadData()
    }
}





























