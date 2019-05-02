//
//  HomeViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/25/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    var books: [Book]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.getAllBooks { (books) in
            print(books)
            self.books = books
        }
        
        print("HIIIIIIII")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
