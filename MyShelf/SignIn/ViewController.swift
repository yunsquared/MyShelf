//
//  ViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/21/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    // MARK: - View vars
    var appNameLabel: UILabel!
    var signInButton: GIDSignInButton!
    
    // MARK: - Constants
    let verticalSpace: CGFloat = 125
    let appName = "MyShelf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .bigRed
        GIDSignIn.sharedInstance().uiDelegate = self
        
        setupViews()
        setupConstraints()
        
    }
    
    func setupViews() {
        appNameLabel = UILabel()
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 40)
        appNameLabel.textAlignment = .center
        appNameLabel.text = appName
        appNameLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 60)
        appNameLabel.textColor = .white
        view.addSubview(appNameLabel)
        
        signInButton = GIDSignInButton()
        signInButton.style = .wide
        signInButton.colorScheme = .light
        view.addSubview(signInButton)
    }
    
    func setupConstraints() {
        appNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Constants.padding)
            make.bottom.equalTo(view.snp.centerY).offset(-verticalSpace / 2)
            make.centerX.equalToSuperview()
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).offset((verticalSpace / 2) + 50)
            make.centerX.equalToSuperview()
        }
    }
    
}
