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
        
        setupConstraints()
        
    }
    
    
    func setupConstraints() {
        
        
        myListingsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(0.5 * padding + navigationController!.navigationBar.frame.height +  UIApplication.shared.statusBarFrame.height)
            make.height.equalTo(40)

        }
//        NSLayoutConstraint.activate([
//            myListingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            myListingsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
//            myListingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
//
//            ])
        
    }

}
