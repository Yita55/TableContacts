//
//  ViewController.swift
//  TableContacts
//
//  Created by James Rochabrun on 4/21/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class ContactListVC: UITableViewController {
    
    var sections = ContactsSource.sectionContacts
    let sectionTitles = ContactsSource.sortedUniqueFirstLettersArray

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { fatalError() }
        let contact = sections[indexPath.section][indexPath.row]
        cell.nameLabel.text = contact.firstName + " " + contact.lastName
        cell.profileImageView.image = contact.image
        cell.cityLabel.text = contact.city
        cell.imageView?.image = contact.isFavorite ? #imageLiteral(resourceName: "team") : nil
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = sections[indexPath.section][indexPath.row]
                guard let contactDetailVC = segue.destination as? ContactDetailVC  else { return }
                contactDetailVC.contact = contact
                contactDetailVC.delegate = self
            }
        }
    }
}

extension ContactListVC:  ContactDetailVCDelegate {
    
    func didMarkAsFavoriteContact(_ contact: Contact) {
        
        var outerIndex: Array.Index? = nil
        var innerIndex: Array.Index? = nil
        
        //contacts is the array of arrays
        for (index, contacts) in sections.enumerated() {
            
            if let indexOfContact = contacts.index(of: contact) {
                outerIndex = index
                innerIndex = indexOfContact
                break
            }
        }
        if let outerIndex = outerIndex, let innerIndex = innerIndex {
            var favoriteContact = sections[outerIndex][innerIndex]
            favoriteContact.isFavorite = true
            sections[outerIndex][innerIndex] = favoriteContact
            
            tableView.reloadData()
        }
    }
}




























