//
//  Book.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/1/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation

struct Book: Codable {
    var id: Int
    var title: String
    var course: String
    var image: String
    var listings: [Int]
}

//struct BookGetDataResponse: Codable {
//    var books: [Book]
//}

struct BookGetResponse: Codable {
    var success: Bool
    var data: [Book]
}

//struct BookPostDataResponse: Codable {
//    var book: Book
//}

struct BookPostResponse: Codable {
    var success: Bool
    var data: Book
}
