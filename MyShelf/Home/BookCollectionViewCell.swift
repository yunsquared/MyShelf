//
//  BookCollectionViewCell.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/5/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    var bookNameLabel: UILabel!
    var bookCourseLabel: UILabel!
    let padding: CGFloat = 8
    let bigLabelHeight: CGFloat = 60
    let smallLabelHeight: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.bigRed.withAlphaComponent(0.9)
        bookNameLabel = UILabel()
        bookNameLabel.numberOfLines = 0
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bookNameLabel.textColor = .black
        bookNameLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 20)
        contentView.addSubview(bookNameLabel)
        
        bookCourseLabel = UILabel()
        bookCourseLabel.translatesAutoresizingMaskIntoConstraints = false
        bookCourseLabel.textColor = .white
        bookCourseLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(bookCourseLabel)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            bookCourseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            bookCourseLabel.bottomAnchor.constraint(equalTo: bookCourseLabel.topAnchor, constant: smallLabelHeight),
            bookCourseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bookCourseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        
        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: bookCourseLabel.bottomAnchor, constant: padding),
//            bookNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bookNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            bookNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
    }
    
    func configure(for book: Book) {
        bookCourseLabel.text = book.course
        bookNameLabel.text = book.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
