//
//  BookViewController.swift
//  MyShelf
//
//  Created by Yunyun S. Wang on 5/3/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit
import SnapKit

protocol ReloadTableViewController: class {
    func reloadTableView()
    
}

class BookViewController: UIViewController {
    
    var padding: CGFloat = 20
    var bookName: String = ""
    var courseName: String = ""
    
    var backButton: UIButton!
//    var bookImage: UIImage!
//    var bookImageView: UIImageView!
    var bookNameLabel: UILabel!
    var classLabel: UILabel!
    var sellButton: UIButton!
    var listings: [Listing] = []
    var listingLabel: UILabel! //include listing number variable
    var listingTableView: UITableView!
    let listingCellReuseIdentifier = "listingCellReuseIdentifier"
//    var refreshControl: UIRefreshControl!
    var listingSellerArray: [(Listing, User)] = []
    var sellerArray: [Listing] = [] //call getBookByName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        bookName = "Gries's Book"
        
        //implementation for book name label
        bookNameLabel = UILabel()
        bookNameLabel.numberOfLines = 0
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.text = bookName
        bookNameLabel.textColor = .bigRed
        bookNameLabel.textAlignment = .center
        bookNameLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 42)
        view.addSubview(bookNameLabel)
        
//        courseName = "Temp Class"
        
        classLabel = UILabel()
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.textColor = .black
        classLabel.text = courseName
        classLabel.textAlignment = .center
        classLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.addSubview(classLabel)
        
        //implementation for button
        sellButton = UIButton()
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        sellButton.backgroundColor = .bigRed
        sellButton.setTitle("Sell This Book", for: .normal)
        sellButton.setTitleColor(.white, for: .normal)
        sellButton.layer.cornerRadius = 20
        sellButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        sellButton.addTarget(self, action: #selector(presentModalViewController), for: .touchUpInside)
        view.addSubview(sellButton)
        
        //implementation for listings label
        listingLabel = UILabel()
        listingLabel.translatesAutoresizingMaskIntoConstraints = false
        listingLabel.text = "Listings"
        listingLabel.textColor = .black
        listingLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        view.addSubview(listingLabel)
        
        let parsedBookName = Helpers.parseString(str: bookName)
        print(parsedBookName)
        
        listingTableView = UITableView()
        listingTableView.translatesAutoresizingMaskIntoConstraints = false
        listingTableView.register(ListingTableViewCell.self, forCellReuseIdentifier: listingCellReuseIdentifier)
        listingTableView.dataSource = self
        listingTableView.delegate = self
        listingTableView.showsVerticalScrollIndicator = false
        view.addSubview(listingTableView)
        
        NetworkManager.getListingByBookName(bookName: parsedBookName) { (listings) in
            self.listings = listings
            for listing in listings {
                NetworkManager.getUserByNetId(netId: String(listing.seller), completion: { (user) in
                    self.listingSellerArray.append((listing, user[0]))
                })
            }
            DispatchQueue.main.async {
                self.listingTableView.reloadData()
            }
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
//            bookNameLabel.bottomAnchor.constraint(equalTo: bookNameLabel.topAnchor, constant: 40),
            bookNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bookNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        NSLayoutConstraint.activate([
            classLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 10),
            classLabel.bottomAnchor.constraint(equalTo: classLabel.topAnchor, constant: 30),
            classLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            classLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        NSLayoutConstraint.activate([
            sellButton.topAnchor.constraint(equalTo: classLabel.bottomAnchor, constant: 20),
            sellButton.bottomAnchor.constraint(equalTo: sellButton.topAnchor, constant: 40),
            sellButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            sellButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
            ])
        NSLayoutConstraint.activate([
            listingLabel.topAnchor.constraint(equalTo: sellButton.bottomAnchor, constant: padding),
            listingLabel.bottomAnchor.constraint(equalTo: listingLabel.topAnchor, constant: 30),
            listingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            listingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        NSLayoutConstraint.activate([
            listingTableView.topAnchor.constraint(equalTo: listingLabel.bottomAnchor, constant: 0.5 * padding),
            listingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            listingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            listingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
    }
    
    @objc func presentModalViewController() {
        let vc = AddListingViewController()
        vc.bookName = bookName
        vc.courseName = courseName
        vc.delegate = self
        // Need to initialize delegate since there is none when you created modalViewController
//        modalViewController.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listingCellReuseIdentifier, for: indexPath) as! ListingTableViewCell
        let listing = listings[indexPath.row]
        let seller = Helpers.findTupleValueInList(tupleList: listingSellerArray, tupleValue: listing)
        cell.sellerName = seller.name
        cell.configure(for: listings[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension BookViewController: ReloadTableViewController {
    
    func reloadTableView() {
        let parsedBookName = Helpers.parseString(str: bookName)
        NetworkManager.getListingByBookName(bookName: parsedBookName) { (listings) in
            self.listings = listings
            for listing in listings {
                NetworkManager.getUserByNetId(netId: String(listing.seller), completion: { (user) in
                    self.listingSellerArray.append((listing, user[0]))
                })
            }
            DispatchQueue.main.async {
                self.listingTableView.reloadData()
            }
        }
        
    }
    
}
