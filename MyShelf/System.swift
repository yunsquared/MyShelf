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
    static var currentUser: String?
    
    static func isNew(user: String) -> Bool {
        if currentUser! == user { return false }
//        return !chats.contains { chat in chat.friend == user }
        return true
    }
    
}
