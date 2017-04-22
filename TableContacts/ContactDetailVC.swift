//
//  ContactDetailVC.swift
//  TableContacts
//
//  Created by James Rochabrun on 4/21/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDetailVCDelegate: class {
    func didMarkAsFavoriteContact(_ contact: Contact)
}

class ContactDetailVC: UITableViewController {
    
    var contact: Contact?
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    weak var delegate: ContactDetailVCDelegate?
    
    
    private func configureView() {
        guard let contact = self.contact else {
            return
        }
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
        streetAddressLabel.text = contact.street
        cityLabel.text = contact.city
        stateLabel.text = contact.state
        zipLabel.text = contact.zip
        profileImageView.image = contact.image
        contactLabel.text = "\(contact.firstName) \(contact.lastName)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    @IBAction func markAsfavorite(_ sender: Any) {
        
        guard let contact = contact else { return }
        delegate?.didMarkAsFavoriteContact(contact)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

