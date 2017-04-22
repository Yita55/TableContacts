//
//  PlistLoader.swift
//  TableContacts
//
//  Created by James Rochabrun on 4/21/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit

enum PlistError: Error {
    
    case invalidResource
    case parsingFailure
}

class PlistLoader {
    
    static func array(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidResource
        }
        
        guard let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            throw PlistError.parsingFailure
        }
        
        return array
    }
}

class ContactsSource {
    
    static var contacts: [Contact] {
        let data = try! PlistLoader.array(fromFile: "ContactsDB", ofType: "plist")
        
        //use flatmap every time you want to check for no nil values 
        //if your initializer is a failable one
        return data.flatMap { Contact(dictionary: $0) }
    }
}

extension ContactsSource {
    
    //this is an array of first letters
    static var sortedUniqueFirstLettersArray: [String] {
        
        let firstLetters = contacts.map{ $0.firstLetterForSort }
        //using a set to avoid duplication
        let uniqueFirstLetters = Set(firstLetters)
        //turning it back to an array to sort it
        return Array(uniqueFirstLetters).sorted()
    }
    
    //this returns an array of arrays
    static var sectionContacts: [[Contact]] {
        //first letter here is each first letter in the array
        //this retruns the array of arrays
        return sortedUniqueFirstLettersArray.map { firstLetter in
            
            //separating arrays by first letters and returning them each time
            let filteredContactsArray = contacts.filter{ $0.firstLetterForSort == firstLetter }
            //example: returning the A section sorted
            return filteredContactsArray.sorted(by: { $0.firstName < $1.firstName })
        }
    }
}



