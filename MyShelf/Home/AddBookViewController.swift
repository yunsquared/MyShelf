//
//  AddBookViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/5/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    var titleLabel: UILabel!
    var titleTextField: UITextField!
    var courseLabel: UILabel!
    var courseTextField: UITextField!
    var addButton: UIButton!
    var deleteButton: UIButton!
    weak var delegate: ReloadCollectionViewController?
    
    let padding: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setImage(UIImage(named: "x button"), for: .normal)
        deleteButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        view.addSubview(deleteButton)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Book Title"
        titleLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        view.addSubview(titleLabel)
        
        titleTextField = UITextField()
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.font = UIFont.systemFont(ofSize: 18)
        titleTextField.backgroundColor = .none
        titleTextField.textColor = .gray
        titleTextField.placeholder = "Ex: University Physics"
        view.addSubview(titleTextField)
        
        courseLabel = UILabel()
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.text = "Course Name"
        courseLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 24)
        view.addSubview(courseLabel)
        
        courseTextField = UITextField()
        courseTextField.translatesAutoresizingMaskIntoConstraints = false
        courseTextField.font = UIFont.systemFont(ofSize: 18)
        courseTextField.textColor = .gray
        courseTextField.backgroundColor = .none
        courseTextField.placeholder = "Ex: PHYS 1112"
        view.addSubview(courseTextField)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = .bigRed
        addButton.setTitle("Add Book", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 20
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        addButton.addTarget(self, action: #selector(createBookAndDismissViewController), for: .touchUpInside)
        view.addSubview(addButton)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
//            titleTextField.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 24),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            courseLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 80),
            courseLabel.bottomAnchor.constraint(equalTo: courseLabel.topAnchor, constant: 24),
            courseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            courseLabel.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            courseTextField.topAnchor.constraint(equalTo: courseLabel.bottomAnchor, constant: padding),
//            courseTextField.bottomAnchor.constraint(equalTo: courseLabel.topAnchor, constant: 24),
            courseTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            courseTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            addButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            addButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 110)
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
    
    
    @objc func createBookAndDismissViewController() {
        if let titleText = titleTextField.text, !titleText.isEmpty {
            if let courseText = courseTextField.text, !courseText.isEmpty {
                NetworkManager.createBook(title: titleText, course: courseText, image: "") { (book) in
                    print("created \(book)")
                    DispatchQueue.main.async {
                        self.delegate?.reloadCollectionView()
                    }
                }
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
