//
//  HomeViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/21/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import Foundation
import Alamofire
import SnapKit

protocol ReloadCollectionViewController: class {
    func reloadCollectionView()
    
}

class HomeViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil) //nil to use same screen for display
    
    var filteredBooks = [Book]()
    var browseBooksLabel: UILabel!
    var sellNewBookButton: UIButton!
    let padding: CGFloat = 20
    
    var books: [Book] = []
    var bookCollectionView: UICollectionView!
    let bookCellReuseIdentifier = "bookCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "My Shelf"
        titleLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 34)
        titleLabel.textColor = .bigRed
        
        self.navigationItem.titleView = titleLabel
        view.backgroundColor = .white
        
        NetworkManager.getAllBooks { (books) in
            self.books = books
            self.filteredBooks = books
            DispatchQueue.main.async {
                self.bookCollectionView.reloadData()
            }
        }
        
        filteredBooks = books
        
        sellNewBookButton = UIButton()
        sellNewBookButton = UIButton()
        sellNewBookButton.translatesAutoresizingMaskIntoConstraints = false
        sellNewBookButton.backgroundColor = .none
        sellNewBookButton.setTitle("ADD NEW BOOK", for: .normal)
        sellNewBookButton.setTitleColor(.blue, for: .normal)
        sellNewBookButton.layer.cornerRadius = 20
        sellNewBookButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        sellNewBookButton.addTarget(self, action: #selector(presentSellBookModalViewController), for: .touchUpInside)
        view.addSubview(sellNewBookButton)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search All Books"
        navigationItem.searchController = searchController
        definesPresentationContext = true //ensures search bar doesn't remain on screen after navigating to view controller
        
        browseBooksLabel = UILabel()
        browseBooksLabel.text = "Browse Books"
        browseBooksLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 26)
        browseBooksLabel.textColor = .black
        view.addSubview(browseBooksLabel)
        
        let bookLayout = UICollectionViewFlowLayout()
        bookLayout.scrollDirection = .vertical
        bookLayout.minimumInteritemSpacing = padding
        bookLayout.minimumLineSpacing = padding
        
        bookCollectionView = UICollectionView(frame: .zero, collectionViewLayout: bookLayout)
        bookCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bookCollectionView.backgroundColor = .white
        bookCollectionView.allowsSelection = true
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        bookCollectionView.allowsMultipleSelection = false
        bookCollectionView.showsVerticalScrollIndicator = false
        bookCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: bookCellReuseIdentifier)
        view.addSubview(bookCollectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        browseBooksLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(0.5 * padding + navigationController!.navigationBar.frame.height + searchController.searchBar.frame.height + UIApplication.shared.statusBarFrame.height)
            make.height.equalTo(40)
     
        }
        
        NSLayoutConstraint.activate([
            sellNewBookButton.topAnchor.constraint(equalTo: browseBooksLabel.topAnchor),
            sellNewBookButton.bottomAnchor.constraint(equalTo: browseBooksLabel.bottomAnchor),
            sellNewBookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            sellNewBookButton.leadingAnchor.constraint(equalTo: sellNewBookButton.trailingAnchor, constant: -140)
            ])
        
        NSLayoutConstraint.activate([
            bookCollectionView.topAnchor.constraint(equalTo: browseBooksLabel.bottomAnchor, constant: 0.25 * padding),
            bookCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            bookCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bookCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        
    }
    
    //write sep helper function
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        if searchBarIsEmpty() {
            filteredBooks = books
        }
        bookCollectionView.reloadData()
    }
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if text empty or null, might be extraneous
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredBooks = books.filter({ ( book: Book) -> Bool in
            return book.title.lowercased().contains(searchText.lowercased())
        })
        
    }
    
    //method to determine if currently filtering results
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc func presentSellBookModalViewController() {
        let vc = AddBookViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result = 0
        result = filteredBooks.count
        return result
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellReuseIdentifier, for: indexPath) as! BookCollectionViewCell
        let book = filteredBooks[indexPath.item]
        cell.configure(for: book)
        cell.selectedBackgroundView = nil
        cell.contentView.layer.cornerRadius = 16
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookVC = BookViewController()
        let cell = filteredBooks[indexPath.item]
        bookVC.bookName = cell.title
        bookVC.courseName = cell.course
        navigationController?.pushViewController(bookVC, animated: true)
        print("selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselected")
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (bookCollectionView.frame.width - (padding)) / 2
        return CGSize(width: length, height: length)
    }
}

extension HomeViewController: ReloadCollectionViewController {
    
    func reloadCollectionView() {
        NetworkManager.getAllBooks { (books) in
            self.books = books
            self.filteredBooks = books
            DispatchQueue.main.async {
                self.bookCollectionView.reloadData()
            }
        }
    }
}
