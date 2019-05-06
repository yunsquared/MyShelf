//
//  SignUpViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/3/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var netIdLabel: UILabel!
    var netIdTextField: UITextField!
    var nameLabel: UILabel!
    var nameTextField: UITextField!
    var registerButton: UIButton!
    var alreadyRegisteredButton: UIButton!
    var padding = CGFloat(20)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        netIdLabel = UILabel()
        netIdLabel.translatesAutoresizingMaskIntoConstraints = false
        netIdLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        netIdLabel.text = "NET ID"
        netIdLabel.textColor = .bigRed
        
        
        netIdTextField = UITextField()
        netIdTextField.translatesAutoresizingMaskIntoConstraints = false
        netIdTextField.backgroundColor = .white
//        netIdTextField.borderStyle = .line
        netIdTextField.placeholder = "Ex: as224"
        netIdTextField.font = UIFont.systemFont(ofSize: 22)
        netIdTextField.textColor = .gray
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        nameLabel.text = "NAME"
        nameLabel.textColor = .bigRed
        
        nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.backgroundColor = .white
//        nameTextField.borderStyle = .line
        nameTextField.placeholder = "Ex: Aaron Smith"
        nameTextField.font = UIFont.systemFont(ofSize: 22)
        nameTextField.textColor = .gray
        
        registerButton = UIButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.backgroundColor = .bigRed
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 20
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        registerButton.addTarget(self, action: #selector(createUserAndPushHomeViewController), for: .touchUpInside)
        
        alreadyRegisteredButton = UIButton()
        alreadyRegisteredButton.translatesAutoresizingMaskIntoConstraints = false
        alreadyRegisteredButton.backgroundColor = .bigRed
        alreadyRegisteredButton.setTitle("Already Registered", for: .normal)
        alreadyRegisteredButton.setTitleColor(.white, for: .normal)
        alreadyRegisteredButton.layer.cornerRadius = 20
        alreadyRegisteredButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        alreadyRegisteredButton.addTarget(self, action: #selector(pushHomeViewController), for: .touchUpInside)
        
        addSubViews()
        setupConstraints()
        
    }
    
    func addSubViews() {
        view.addSubview(netIdLabel)
        view.addSubview(netIdTextField)
        view.addSubview(nameTextField)
        view.addSubview(nameLabel)
        view.addSubview(registerButton)
        view.addSubview(alreadyRegisteredButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            netIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            netIdLabel.trailingAnchor.constraint(equalTo: netIdLabel.leadingAnchor, constant: 70),
            netIdLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            netIdLabel.bottomAnchor.constraint(equalTo: netIdLabel.topAnchor, constant: 60)
            ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: netIdLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: netIdLabel.leadingAnchor, constant: 70),
            nameLabel.topAnchor.constraint(equalTo: netIdLabel.bottomAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 60)
            ])
        NSLayoutConstraint.activate([
            netIdTextField.leadingAnchor.constraint(equalTo: netIdLabel.trailingAnchor, constant: padding),
            netIdTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            netIdTextField.topAnchor.constraint(equalTo: netIdLabel.topAnchor),
            netIdTextField.bottomAnchor.constraint(equalTo: netIdLabel.bottomAnchor, constant: 5)
            ])
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
            ])
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -160)
            ])
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -260),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220),
            registerButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            registerButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
            ])
        NSLayoutConstraint.activate([
            alreadyRegisteredButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            alreadyRegisteredButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            alreadyRegisteredButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            alreadyRegisteredButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
            ])
    }
    
    @objc func test() {
        NetworkManager.getUserByNetId(netId: "ssj541") { (user) in
            print(user)
        }
    
    }

    @objc func createUserAndPushHomeViewController() {
        if let netIdText = netIdTextField.text, !netIdText.isEmpty {
            if let nameText = nameTextField.text, !nameText.isEmpty {
                let vc = TabBarViewController()
                present(vc, animated: true, completion: nil)
                print("hi")
                NetworkManager.createUser(name: nameText, netId: netIdText.lowercased(), pfp: "") { (user) in
                    System.user = user
                }
            }
        }
    }
    
    @objc func pushHomeViewController() {
        if let netIdText = netIdTextField.text, !netIdText.isEmpty {
            if let nameText = nameTextField.text, !nameText.isEmpty {
                let vc = TabBarViewController()
                NetworkManager.getUserByNetId(netId: netIdText) { user in
                    System.user = user[0]
                }
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    

}
