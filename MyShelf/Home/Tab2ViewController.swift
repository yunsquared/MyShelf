//
//  Tab2ViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/4/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController {
    
    var myListingsLabel: UILabel!
    let padding: CGFloat = 20
    
    var listings: [Listing] = []
    var listingTableView: UITableView!
    let listingTabCellReuseIdentifier = "listingTabCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "My Shelf"
        titleLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 34)
        titleLabel.textColor = .bigRed
        
        self.navigationItem.titleView = titleLabel
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        myListingsLabel = UILabel()
        myListingsLabel.text = "My Listings"
        myListingsLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 26)
        myListingsLabel.textColor = .black
        view.addSubview(myListingsLabel)
        
        listingTableView = UITableView()
        listingTableView.translatesAutoresizingMaskIntoConstraints = false
        listingTableView.register(ListingTabTableViewCell.self, forCellReuseIdentifier: listingTabCellReuseIdentifier)
        listingTableView.dataSource = self
        listingTableView.delegate = self
        listingTableView.showsVerticalScrollIndicator = false
        view.addSubview(listingTableView)
        
        NetworkManager.getListingByUserNetId(netId: System.user.netid) { (listings) in
            self.listings = listings
            DispatchQueue.main.async {
                self.listingTableView.reloadData()
            }
        }
        
        setupConstraints()
        
    }
    
    
    func setupConstraints() {
        
        myListingsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(0.5 * padding + navigationController!.navigationBar.frame.height +  UIApplication.shared.statusBarFrame.height)
            make.height.equalTo(40)
        }
        
        NSLayoutConstraint.activate([
            listingTableView.topAnchor.constraint(equalTo: myListingsLabel.bottomAnchor, constant: 0.25 * padding),
            listingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            listingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            listingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        
        
        
    }

}
extension Tab2ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listingTabCellReuseIdentifier, for: indexPath) as! ListingTabTableViewCell
        let listing = listings[indexPath.row]
        cell.configure(for: listing)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
