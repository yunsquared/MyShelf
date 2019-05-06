//
//  AddListingViewController.swift
//  MyShelf
//
//  Created by Yunyun S. Wang on 5/3/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController {
    
    var bookName: String = ""
    var bookTitle: UILabel!
    var courseName: String = ""
    
    var priceLabel: UILabel!
    var dollarLabel: UILabel!
    var priceTextField: UITextField!
    var conditionLabel: UILabel!
    var conditionTextField: UITextField!
    var notesLabel: UILabel!
    var notesTextField: UITextField!
    var sellButton: UIButton!
    var deleteButton: UIButton!
    weak var delegate: ReloadTableViewController?
    
    let padding: CGFloat = 20

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set title of controller in nav
        //set class of controller in nav
        view.backgroundColor = .white
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setImage(UIImage(named: "x button"), for: .normal)
        deleteButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(deleteButton)

        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "Price"
        priceLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        view.addSubview(priceLabel)
        
        dollarLabel = UILabel()
        dollarLabel.translatesAutoresizingMaskIntoConstraints = false
        dollarLabel.text = "$"
        dollarLabel.textAlignment = .right
        dollarLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(dollarLabel)

        priceTextField = UITextField()
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.font = UIFont.systemFont(ofSize: 24)
        priceTextField.backgroundColor = .none
        priceTextField.textColor = .gray
        priceTextField.placeholder = "Ex: 24"
        view.addSubview(priceTextField)
        
        conditionLabel = UILabel()
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.text = "Condition"
        conditionLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        view.addSubview(conditionLabel)
        
        conditionTextField = UITextField()
        conditionTextField.translatesAutoresizingMaskIntoConstraints = false
        conditionTextField.font = UIFont.systemFont(ofSize: 24)
        conditionTextField.textColor = .gray
        conditionTextField.backgroundColor = .none
        conditionTextField.placeholder = "Ex: Good"
        view.addSubview(conditionTextField)
        
        notesLabel = UILabel()
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.text = "Notes"
        notesLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        view.addSubview(notesLabel)
        
        notesTextField = UITextField()
        notesTextField.translatesAutoresizingMaskIntoConstraints = false
        notesTextField.backgroundColor = .none
        notesTextField.textAlignment = .left
        notesTextField.contentVerticalAlignment = .top
        notesTextField.placeholder = "Some of the pages have writing, but..."
        view.addSubview(notesTextField)
        
        sellButton = UIButton()
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        sellButton.backgroundColor = .bigRed
        sellButton.setTitle("Post Listing", for: .normal)
        sellButton.setTitleColor(.white, for: .normal)
        sellButton.layer.cornerRadius = 20
        sellButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        sellButton.addTarget(self, action: #selector(createListingAndDismissViewController), for: .touchUpInside)
        view.addSubview(sellButton)
        
        setupConstraints()
        print(courseName)
        print(bookName)
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            priceLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 24),
            priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            priceLabel.widthAnchor.constraint(equalToConstant: 125)
            ])
        
        NSLayoutConstraint.activate([
            priceTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            priceTextField.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 24),
            priceTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            priceTextField.leadingAnchor.constraint(equalTo: priceTextField.trailingAnchor, constant: -120)
            ])
        
        NSLayoutConstraint.activate([
            dollarLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            dollarLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 24),
            dollarLabel.trailingAnchor.constraint(equalTo: priceTextField.leadingAnchor, constant: -2),
            dollarLabel.widthAnchor.constraint(equalToConstant: 50)
            ])
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 80),
            conditionLabel.bottomAnchor.constraint(equalTo: conditionLabel.topAnchor, constant: 24),
            conditionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            conditionLabel.widthAnchor.constraint(equalToConstant: 125)
            ])
        
        NSLayoutConstraint.activate([
            conditionTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 80),
            conditionTextField.bottomAnchor.constraint(equalTo: conditionLabel.topAnchor, constant: 24),
            conditionTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            conditionTextField.leadingAnchor.constraint(equalTo: conditionTextField.trailingAnchor, constant: -120)
            ])
        
        NSLayoutConstraint.activate([
            notesLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 80),
            notesLabel.bottomAnchor.constraint(equalTo: notesLabel.topAnchor, constant: 24),
            notesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            notesLabel.widthAnchor.constraint(equalToConstant: 125)
            ])
        
        //constraints for NotesTextField
        NSLayoutConstraint.activate([
            notesTextField.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 114),
            notesTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            notesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            notesTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
            ])
        
        NSLayoutConstraint.activate([
            sellButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            sellButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            sellButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            sellButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
            ])
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
//            deleteButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
            ])
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func createListingAndDismissViewController() {
        if let priceText = priceTextField.text, !priceText.isEmpty {
            if let conditionText = conditionTextField.text, !conditionText.isEmpty {
                if let notesText = notesTextField.text, !notesText.isEmpty {
                    NetworkManager.createListing(title: bookName, netId: System.user.netid, course: courseName, price: priceText, condition: conditionText, notes: notesText, image: "") { (listing) in
                        print("created \(listing)")
                        DispatchQueue.main.async {
                            self.delegate?.reloadTableView()
                        }
                    }
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
