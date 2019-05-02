//
//  Listing.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/29/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation


struct Listing: Codable {
    var id: Int
    var title: String
    var price: String
    var condition: String
    var image: String
    var course: String
    var seller: Int
    var book: Int
}

//struct ListingGetDataResponse: Codable {
//    var books: [Listing]
//}

struct ListingGetResponse: Codable {
    var success: Bool
    var data: [Listing]
}

//struct ListingPostDataResponse: Codable {
//    var books: Listing
//}

struct ListingPostResponse: Codable {
    var success: Bool
    var data: Listing
}

