//
//  System.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/25/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation

class System {
    
//    static var chats = [Chat]()
    static var userName: String?
    static var user: User!
    static var users: [User]!
    static var userBooks: [Book]!
    static var userListings: [Listing]!
    static var allBooks: [Book]!
    static var bookNameListingDictionary: [String: [Listing]]!
    
    static func isNew(user: String) -> Bool {
        if userName! == user { return false }
//        return !chats.contains { chat in chat.friend == user }
        return true
    }
    
}
