//
//  Contact.swift
//  TableContacts
//
//  Created by James Rochabrun on 4/21/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

struct Contact {
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    let street: String
    let city: String
    let state: String
    let zip: String
    let image: UIImage?
    var isFavorite: Bool
}

extension Contact {
    
    struct Key {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phone = "phoneNumber"
        static let email = "email"
        static let street = "streetAddress"
        static let city = "city"
        static let state = "state"
        static let zip = "zip"
        static let image = "avatarName"
    }
    
    init?(dictionary: [String: String]) {
        guard let firstNameString = dictionary[Key.firstName],
            let lastNameString = dictionary[Key.lastName],
            let phoneString = dictionary[Key.phone],
            let emailString = dictionary[Key.email],
            let streetString = dictionary[Key.street],
            let cityString = dictionary[Key.city],
            let stateString = dictionary[Key.state],
            let zipString = dictionary[Key.zip] else { return nil }
        
        self.firstName = firstNameString
        self.lastName = lastNameString
        self.phone = phoneString
        self.email = emailString
        self.street = streetString
        self.city = cityString
        self.state = stateString
        self.zip = zipString
        
        if let imageName = dictionary[Key.image] {
            self.image = UIImage(named: imageName)
        } else {
            image = nil
        }
        isFavorite = false
    }
}

//conform to the equatable protocol
extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.street == rhs.street && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.phone == rhs.phone && lhs.email == rhs.email
    }
}


extension Contact {
    
    //check for the first letter of each first Name
    var firstLetterForSort: String {
        return String(describing: firstName.characters.first!).uppercased()
    }
}

