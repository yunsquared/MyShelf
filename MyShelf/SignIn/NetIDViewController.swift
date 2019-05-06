////
////  NetIDViewController.swift
////  MyShelf
////
////  Created by Steven Jiang on 5/5/19.
////  Copyright © 2019 Steven Jiang. All rights reserved.
////
//
//import UIKit
//
//class NetIDViewController: UIViewController {
//
//    var netIdLabel: UILabel!
//    var netIdTextField: UITextField!
//    var nextButton: UIButton!
//    let padding = CGFloat(20)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        // Do any additional setup after loading the view.
//        netIdLabel = UILabel()
//        netIdLabel.translatesAutoresizingMaskIntoConstraints = false
//        netIdLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        netIdLabel.text = "NET ID"
//        netIdLabel.textColor = .bigRed
//        view.addSubview(netIdLabel)
//
//
//        netIdTextField = UITextField()
//        netIdTextField.translatesAutoresizingMaskIntoConstraints = false
//        netIdTextField.backgroundColor = .white
//        netIdTextField.placeholder = "Ex: as224"
//        netIdTextField.font = UIFont.systemFont(ofSize: 22)
//        netIdTextField.textColor = .gray
//        view.addSubview(netIdTextField)
//
//        nextButton = UIButton()
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.backgroundColor = .bigRed
//        nextButton.setTitle("Next", for: .normal)
//        nextButton.setTitleColor(.white, for: .normal)
//        nextButton.layer.cornerRadius = 20
//        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        nextButton.addTarget(self, action: #selector(pushNextViewController), for: .touchUpInside)
//        view.addSubview(nextButton)
//
//        setupConstraints()
//    }
//
//    func setupConstraints() {
//
//        NSLayoutConstraint.activate([
//            netIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            netIdLabel.trailingAnchor.constraint(equalTo: netIdLabel.leadingAnchor, constant: 70),
//            netIdLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
//
//        NSLayoutConstraint.activate([
//            netIdTextField.leadingAnchor.constraint(equalTo: netIdLabel.trailingAnchor, constant: padding),
//            netIdTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            netIdTextField.topAnchor.constraint(equalTo: netIdLabel.topAnchor),
//            netIdTextField.bottomAnchor.constraint(equalTo: netIdLabel.bottomAnchor, constant: 5)
//            ])
//
//        NSLayoutConstraint.activate([
//            nextButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
//            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
//            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
//            nextButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
//            ])
//
//    }
//
//    @objc func pushNextViewController() {
//        if let netIdText = netIdTextField.text, !netIdText.isEmpty {
//            NetworkManager.getUserByNetId(netId: netIdText.lowercased()) { user in
//                System.user = user[0]
//            }
//            if let user = System.user {
//                present(TabBarViewController(), animated: true)
//            } else {
//                present(SignUpViewController(), animated: true)
//            }
//
//        }
//    }
//
//}
//
//
////
////  SignUpViewController.swift
////  MyShelf
////
////  Created by Steven Jiang on 5/3/19.
////  Copyright © 2019 Steven Jiang. All rights reserved.
////
//
//import UIKit
//
//class SignUpViewController: UIViewController {
//
//    var netId: String = ""
//    var nameLabel: UILabel!
//    var nameTextField: UITextField!
//    var nextButton: UIButton!
//    var padding = CGFloat(20)
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        nameLabel = UILabel()
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        nameLabel.text = "NAME"
//        nameLabel.textColor = .bigRed
//        view.addSubview(nameLabel)
//
//
//        nameTextField = UITextField()
//        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//        nameTextField.backgroundColor = .white
//        nameTextField.placeholder = "Ex: Andrew Smith"
//        nameTextField.font = UIFont.systemFont(ofSize: 22)
//        nameTextField.textColor = .gray
//        view.addSubview(nameTextField)
//
//        nextButton = UIButton()
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.backgroundColor = .bigRed
//        nextButton.setTitle("Next", for: .normal)
//        nextButton.setTitleColor(.white, for: .normal)
//        nextButton.layer.cornerRadius = 20
//        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        nextButton.addTarget(self, action: #selector(createUserAndPushHomeViewController), for: .touchUpInside)
//        view.addSubview(nextButton)
//
//        setupConstraints()
//
//    }
//
//    func setupConstraints() {
//
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            nameLabel.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 70),
//            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//            ])
//
//        NSLayoutConstraint.activate([
//            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
//            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
//            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
//            ])
//
//        NSLayoutConstraint.activate([
//            nextButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
//            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
//            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
//            nextButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
//            ])
//
//    }
//
//    @objc func createUserAndPushHomeViewController() {
//        if let nameText = nameTextField.text, !nameText.isEmpty {
//            let vc = TabBarViewController()
//            present(vc, animated: true, completion: nil)
//            print("new user")
//            NetworkManager.createUser(name: nameText, netId: netId.lowercased(), pfp: "") { (user) in
//                System.user = user
//            }
//        }
//    }
//
//    //    @objc func pushHomeViewController() {
//    //        if let netIdText = nameTextField.text, !netIdText.isEmpty {
//    //            if let nameText = nameTextField.text, !nameText.isEmpty {
//    //                let vc = TabBarViewController()
//    //                NetworkManager.getUserByNetId(netId: netIdText) { user in
//    //                    System.user = user[0]
//    //                }
//    //                navigationController?.pushViewController(vc, animated: true)
//    //            }
//    //        }
//    //    }
//
//
//}
