//
//  TabBarViewController.swift
//  MyShelf
//
//  Created by Steven Jiang on 5/4/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        vc1.tabBarItem.title = "Browse"
        vc1.tabBarItem.image = UIImage(named: "home")
        
        let vc2 = Tab2ViewController()
        vc2.tabBarItem.title = "My Listings"
        vc2.tabBarItem.image = UIImage(named: "classes")
        
        viewControllers = [UINavigationController(rootViewController: vc1), UINavigationController(rootViewController: vc2)]
        
        // Do any additional setup after loading the view.
    }
}
