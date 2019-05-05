//
//  Network Manager.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/29/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
//  GET (get all books),
    private static let booksEndpoint = "http://35.245.254.67/api/books/"
//  GET (get books by course, need course name),
    private static let booksByCourseNameEndpoint = "http://35.245.254.67/api/books/course/"
//  GET (get book by book title, need book title)
    private static let bookByNameEndpoint = "http://35.245.254.67/api/books/book/"
//  GET (get book by book id, need book id)
    private static let bookByIdEndpoint = "http://35.245.254.67/api/books/book/id/"
//  GET (get user by netId, need user netId)
    private static let userByIdEndpoint = "http://35.245.254.67/api/user/"
//  GET (get listing by id, need listing id)
    private static let listingByIdEndpoint = "http://35.245.254.67/api/listing/"
//  GET (get listings by user netId, need user netId)
    private static let listingByNetIdEndpoint = "http://35.245.254.67/api/listings/user/"
//  GET (get listings by book name, need book name)
    private static let listingByBookNameEndpoint = "http://35.245.254.67/api/listings/book/"

//  POST (make a new user, need: name, netid, pfp)
    private static let createUserEndpoint = "http://35.245.254.67/api/users/"
//  POST (make a new book, need: title, course, image)
    private static let createBookEndpoint = "http://35.245.254.67/api/book/"
//  POST (make a new listing, need: title, netid, course, price, condition, notes, image)
    private static let createListingEndpoint = "http://35.245.254.67/api/listings/"
    
//  DELETE (delete a listing by id, need listing id)
    private static let deleteListingEndpoint = "http://35.245.254.67/api/listing/"
    
    
//  Gets all the books in the api, requires a completion handler that takes a book array and returns void
    static func getAllBooks(completion: @escaping ([Book]) -> Void) {
        Alamofire.request(booksEndpoint, method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let bookResponse = try? jsonDecoder.decode(BookGetResponse.self, from: data) {
                    let books = bookResponse.data
                    completion(books)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
//  Gets all the books in the api corresponding to a course name, requires a course name and a completion handler that takes a book array and returns void
//  Need: Course Name
    static func getBooksByCourseName(courseName: String, completion: @escaping ([Book]) -> Void) {
        Alamofire.request(booksByCourseNameEndpoint + courseName + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let bookResponse = try? jsonDecoder.decode(BookGetResponse.self, from: data) {
                    let books = bookResponse.data
                    completion(books)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

//  Gets book in the api corresponding to a book name, requires a book name and a completion handler that takes a book array and returns void
//  Need: Book Name
    static func getBookByName(bookName: String, completion: @escaping ([Book]) -> Void ) {
        Alamofire.request(bookByNameEndpoint + bookName + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let bookResponse = try? jsonDecoder.decode(BookGetResponse.self, from: data) {
                    let book = bookResponse.data
                    completion(book)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
//  Gets book in the api corresponding to an id, requires an id and a completion handler that takes a book array and returns void
//  Need: Book ID
    static func getBookById(id: Int, completion: @escaping ([Book]) -> Void) {
        Alamofire.request(bookByIdEndpoint + String(id) + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let bookResponse = try? jsonDecoder.decode(BookGetResponse.self, from: data) {
                    let book = bookResponse.data
                    completion(book)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//  Gets user in the api corresponding to a user netId, requires a netId and a completion handler that takes a user array and returns void
//  Need: User NetId
    static func getUserByNetId(netId: String, completion: @escaping ([User]) -> Void) {
        Alamofire.request(userByIdEndpoint + netId + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(UserGetResponse.self, from: data) {
                    let user = userResponse.data
                    completion(user)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("alamo request didn't work")
                print(netId)
            }
        }
    }
    
//    static func isUser(netId: String) -> Int {
//        Alamofire.request(userByIdEndpoint + netId, method: .get).validate().responseData { (response) in
//            switch response.result {
//            case.success(let data):
//                let jsonDecoder = JSONDecoder()
//                if let userResponse = try? jsonDecoder.decode(UserGetResponse.self, from: data) {
//                    return true
//
//                } else {
//                    return false
//                }
//            case .failure(let error):
//                return false
//            }
//        }
//    }
    
//  Gets listing in the api corresponding to a listing id, requires an id and a completion handler that takes a listing array and returns void
//  Need: Listing ID
    static func getListingById(id: Int, completion: @escaping ([Listing]) -> Void) {
        Alamofire.request(listingByIdEndpoint + String(id) + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let listingResponse = try? jsonDecoder.decode(ListingGetResponse.self, from: data) {
                    let listing = listingResponse.data
                    completion(listing)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//  Gets all listings in the api corresponding to a user netId, requires a netId and a completion handler that takes a listing array and returns void
//  Need: User NetId
    static func getListingByUserNetId(netId: String, completion: @escaping ([Listing]) -> Void) {
        Alamofire.request(listingByNetIdEndpoint + netId + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let listingResponse = try? jsonDecoder.decode(ListingGetResponse.self, from: data) {
                    let listings = listingResponse.data
                    completion(listings)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //  Gets all listings in the api corresponding to a book name, requires a netId and a completion handler that takes a listing array and returns void
    //  Need: User NetId
    static func getListingByBookName(bookName: String, completion: @escaping ([Listing]) -> Void) {
        Alamofire.request(listingByBookNameEndpoint + bookName + "/", method: .get).validate().responseData { (response) in
            switch response.result {
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if let listingResponse = try? jsonDecoder.decode(ListingGetResponse.self, from: data) {
                    let listings = listingResponse.data
                    completion(listings)
                } else {
                    print("Invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//  Creates a user in the api corresponding to a name, netId, pfp (which should be "" for now) and requires a name, a netId, a pfp and a completion handler that takes a user and returns void
//  Need: Name, NetId, Pfp
    static func createUser(name: String, netId: String, pfp: String, completion: @escaping (User) -> Void) {
        let parameters: [String: String] = [
            "name": String(name),
            "netid": String(netId),
            "pfp": String(pfp)
        ]
        Alamofire.request(createUserEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                print(data)
                if let userResponse = try? jsonDecoder.decode(UserPostResponse.self, from: data) {
                    let user = userResponse.data
                    completion(user)
                    print("created user with parameters \(user)")
                } else {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print(json)
                    }
                    print("didnt go into if statement")
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }

//  Creates a book in the api corresponding to a title, course, image (which should be "" for now) and requires a title, a course name, an image, and a completion handler that takes a user and returns void
//  Need: Title, Course, Image
    static func createBook(title: String, course: String, image: String, completion: @escaping (Book) -> Void) {
        let parameters: [String: Any] = [
            "title": title,
            "course": course,
            "image": image
        ]
        Alamofire.request(createBookEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let bookResponse = try? jsonDecoder.decode(BookPostResponse.self, from: data) {
                    let book = bookResponse.data
                    completion(book)
                    print("created listing with parameters \(book)")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//  Creates a listing in the api corresponding to a book title, a user netId, a course name, a price, a condition, notes, an image (which should be "" for now) and requires a title, a netId, a course name, a price, a condition, notes, an image, and a completion handler that takes a user and returns void
//  Need: Title, NetId, Course, Price, Condition, Notes, Image
    static func createListing(title: String, netId: String, course: String, price: String, condition: String, notes: String, image: String, completion : @escaping (Listing) -> Void) {
        let parameters: [String: Any] = [
            "title": title,
            "netid": netId,
            "course": course,
            "price": price,
            "condition": condition,
            "notes": notes,
            "image": image
        ]
        Alamofire.request(createListingEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let listingResponse = try? jsonDecoder.decode(ListingPostResponse.self, from: data) {
                    let listing = listingResponse.data
                    completion(listing)
                    print("created listing with parameters \(listing)")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//  Deletes a listing from the api corresponding to a listing id, requires an id and a completion handler that takes a Listing and returns void
//  Need: Listing ID
    static func deleteListingById(id: Int, completion: @escaping (Listing) -> Void) {
        Alamofire.request(deleteListingEndpoint + String(id) + "/", method: .delete).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let listingResponse = try? jsonDecoder.decode(ListingPostResponse.self, from: data) {
                    let listing = listingResponse.data
                    completion(listing)
                    print("deleted listing with parameters \(listing)")
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
