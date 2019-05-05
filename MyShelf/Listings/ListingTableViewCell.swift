//
//  ListingTableViewCell.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/4/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    var sellerNameLabel: UILabel!
    var conditionLabel: UILabel!
    var priceLabel: UILabel!
    var sellerName: String = ""
    
    let padding: CGFloat = 8
    let bigLabelHeight: CGFloat = 24
    let smallLabelHeight: CGFloat = 14
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sellerNameLabel = UILabel()
        sellerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        sellerNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        contentView.addSubview(sellerNameLabel)
        
        conditionLabel = UILabel()
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.font = UIFont.systemFont(ofSize: 14)
        conditionLabel.textColor = .init(red: 17/255.0, green: 166/255.0, blue: 0, alpha: 1)
        contentView.addSubview(conditionLabel)
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        priceLabel.textColor = .bigRed
        priceLabel.textAlignment = .right
        contentView.addSubview(priceLabel)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            sellerNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sellerNameLabel.trailingAnchor.constraint(equalTo: sellerNameLabel.leadingAnchor, constant: 200),
            sellerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            sellerNameLabel.heightAnchor.constraint(equalToConstant: bigLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            conditionLabel.leadingAnchor.constraint(equalTo: sellerNameLabel.leadingAnchor),
            conditionLabel.trailingAnchor.constraint(equalTo: sellerNameLabel.trailingAnchor),
            conditionLabel.topAnchor.constraint(equalTo: sellerNameLabel.bottomAnchor),
            conditionLabel.heightAnchor.constraint(equalToConstant: smallLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            priceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: -120),
            priceLabel.topAnchor.constraint(equalTo: sellerNameLabel.topAnchor),
            priceLabel.heightAnchor.constraint(equalTo: sellerNameLabel.heightAnchor)
            ])
    }
    
    func configure(for listing: Listing) {
        
//        NEED TO CONFIGURE EACH CELL TO HAVE RIGHT SELLER NAME, HOW DO YOU RELOAD DATA FOR TABLEVIEW in SUPERCLASS
        
        
        sellerNameLabel.text = sellerName
        conditionLabel.text = listing.condition
        priceLabel.text = "$" + listing.price
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
