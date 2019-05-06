//
//  ListingTabTableViewCell.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/5/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class ListingTabTableViewCell: UITableViewCell {
    
    var conditionLabel: UILabel!
    var priceLabel: UILabel!
    var bookNameLabel: UILabel!
    var courseLabel: UILabel!
    
    let padding: CGFloat = 8
    let bigLabelHeight: CGFloat = 28
    let smallLabelHeight: CGFloat = 18
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bookNameLabel = UILabel()
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        bookNameLabel.textColor = .darkGray
        contentView.addSubview(bookNameLabel)
        
        courseLabel = UILabel()
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.font = UIFont.systemFont(ofSize: 16)
        courseLabel.textColor = .lightGray
        contentView.addSubview(courseLabel)
        
        conditionLabel = UILabel()
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.font = UIFont.systemFont(ofSize: 16)
        conditionLabel.textAlignment = .right
        conditionLabel.textColor = .init(red: 17/255.0, green: 166/255.0, blue: 0, alpha: 1)
        contentView.addSubview(conditionLabel)
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        priceLabel.textColor = .bigRed
        priceLabel.textAlignment = .right
        contentView.addSubview(priceLabel)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            bookNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookNameLabel.trailingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor, constant: 280),
            bookNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.5 * padding),
            bookNameLabel.heightAnchor.constraint(equalToConstant: bigLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            courseLabel.leadingAnchor.constraint(equalTo: bookNameLabel.leadingAnchor),
            courseLabel.trailingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor),
            courseLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: padding),
            courseLabel.heightAnchor.constraint(equalToConstant: smallLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            priceLabel.leadingAnchor.constraint(equalTo: bookNameLabel.trailingAnchor, constant: padding),
            priceLabel.topAnchor.constraint(equalTo: bookNameLabel.topAnchor),
            priceLabel.heightAnchor.constraint(equalTo: bookNameLabel.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            conditionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            conditionLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: -120),
            conditionLabel.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: padding),
            conditionLabel.heightAnchor.constraint(equalToConstant: smallLabelHeight)
            ])
        
        
    }
    
    func configure(for listing: Listing) {
        
        bookNameLabel.text = listing.title
        courseLabel.text = listing.course
        conditionLabel.text = listing.condition
        priceLabel.text = "$" + listing.price
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
