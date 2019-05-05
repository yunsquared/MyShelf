//
//  Helpers.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/4/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation

class Helpers {
    static func addToDictionary(courseName: String, listing: Listing) {
        if let entry = System.bookNameListingDictionary[courseName] {
            System.bookNameListingDictionary[courseName] = entry + [listing]
        } else {
            System.bookNameListingDictionary[courseName] = [listing]
        }
    }

    static func parseString(str: String) -> String {
        var result = ""
        var i = 0
        let components = str.components(separatedBy: " ")
        while i < components.count {
            if i == 0 {
                result += components[i]
            } else {
                result += "%20" + components[i]
            }
            i += 1
        }
        return result
    }
}
