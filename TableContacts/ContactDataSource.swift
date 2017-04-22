//
//  ContactListDataSource.swift
//  TableContacts
//
//  Created by James Rochabrun on 4/22/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

class ContactsDataSource: NSObject, UITableViewDataSource {
    
    private var sectionedData: [[Contact]]
    let sectionTitles: [String]
    
    init(sectionedData: [[Contact]], sectionTitles: [String]) {
        self.sectionedData = sectionedData
        self.sectionTitles = sectionTitles
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else { fatalError() }
        let contact = sectionedData[indexPath.section][indexPath.row]
        cell.nameLabel.text = contact.firstName + " " + contact.lastName
        cell.profileImageView.image = contact.image
        cell.cityLabel.text = contact.city
        cell.imageView?.image = contact.isFavorite ? #imageLiteral(resourceName: "team") : nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    //MARK: - Helper methods
    func object(at indexPath: IndexPath) -> Contact {
        return sectionedData[indexPath.section][indexPath.row]
    }
    
    func indexPath(for contact: Contact) -> IndexPath? {
        
        for (index, contacts) in sectionedData.enumerated() {
            if let indexOfContact = contacts.index(of: contact)  {
                return IndexPath(row: indexOfContact, section: index)
            }
        }
        return nil
    }
    
    //updating the data source
    func updateContact(_ contact: Contact, at indexPath: IndexPath) {
        sectionedData[indexPath.section][indexPath.row] = contact
    }
}
