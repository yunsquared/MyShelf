//
//  User.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/29/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation


struct User: Codable {
    var id: Int
    var name: String
    var netid: String
    var pfp: String
    var listings: [Int]
}
//
//struct UserGetDataResponse: Codable {
//    var user: [User]
//}

struct UserGetResponse: Codable {
    var success: Bool
    var data: [User]
}
//
//struct UserPostDataResponse: Codable {
//    var user: User
//}

struct UserPostResponse: Codable {
    var success: Bool
    var data: User
}

func getNetId() -> String {
    return System.user.netid ?? "Nil"
}
