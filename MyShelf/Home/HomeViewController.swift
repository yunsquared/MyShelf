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

class HomeViewController: UIViewController, UISearchResultsUpdating {
    
    //var shelfResultsTableController: ShelfResultsTableController!
    let searchController = UISearchController(searchResultsController: nil) //nil to use same screen for display
    
    var filteredBooks = [Book]()
    var browseBooksLabel: UILabel!
    let padding: CGFloat = 20
    
    var books: [Book] = []
    var bookCollectionView: UICollectionView!
    let bookCellReuseIdentifier = "bookCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewDidLoad()
        
        // Do any additional setup after loading the view.
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.text = "My Shelf"
        titleLabel.font = UIFont.init(name: "NoeDisplay-bold", size: 34)
        titleLabel.textColor = .bigRed
        
        self.navigationItem.titleView = titleLabel
        view.backgroundColor = .white
//
//        let physics = Book(id: 1, title: "Physics 1", course: "Phys 1112", image: "", listings: [])
//        let physics2 = Book(id: 2, title: "Physics 2", course: "Phys 2213", image: "", listings: [])
//
//        books = [physics, physics2]
        
        NetworkManager.getAllBooks { (books) in
            self.books = books
            self.filteredBooks = books
            DispatchQueue.main.async {
                self.bookCollectionView.reloadData()
            }
        }
        
        filteredBooks = books
        
        //set up Search Controller
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
        
        //shelfResultsTableController = ShelfResultsTableController()
        
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
    
    //method to check whether user is searching and using either filtered or original books as data source
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering() {
//            return filteredBooks.count
//        }
//
//        return books.count
//    }
//
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let book: Book
//        if isFiltering() {
//            book = filteredBooks[indexPath.row]
//        } else {
//            book = books[indexPath.row]
//        }
//        cell.textLabel!.text = book.title
//        cell.detailTextLabel!.text = book.course
//        return cell
//    }
//
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if segue.identifier == "showDetail" {
    //            if let indexPath = tableView.indexPathForSelectedRow {
    //                let candy = candies[indexPath.row]
    //                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
    //                controllerdetailCandy = candy
    //                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    //                controller.navigationItem.leftItemsSupplementBackButton = true
    //            }
    //
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var result = 0
        result = filteredBooks.count
        return result
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookCellReuseIdentifier, for: indexPath) as! BookCollectionViewCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        cell.selectedBackgroundView = backgroundView
        let book = filteredBooks[indexPath.item]
        cell.configure(for: book)
        cell.selectedBackgroundView = nil
        cell.contentView.layer.cornerRadius = 16
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        PRESENT BOOK VIEW CORRESPONDING TO BOOK AT ITEMAT
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
