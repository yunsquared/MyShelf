//
//  AppDelegate.swift
//  MyShelf
//
//  Created by Steven Jiang on 4/21/19.
//  Copyright © 2019 Steven Jiang. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import SnapKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//      Configure is always the first step
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController() ?? UIViewController()
        window?.makeKeyAndVisible()

        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            DispatchQueue.main.async {
                //              Calls did sign in for method
                GIDSignIn.sharedInstance()?.signInSilently()
//                self.window?.rootViewController = TabBarViewController()
            }
        } else {
            window?.rootViewController = ViewController()
        }
        
        return true
    }
    
    
        func changeVC() {
            window?.rootViewController = TabBarViewController()
        }
    
        func getUsername(email: String) -> String {
            let components = email.components(separatedBy: "@")
            return components[0]
        }
    
        func getDomain(email: String) -> String {
            let components = email.components(separatedBy: "@")
            return components[1]
        }
    
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//            if getDomain(email: user.profile.email) != "cornell.edu" {
//                window?.rootViewController = ViewController()
//                return
//            }
            if let error = error {
                print(error.localizedDescription)
                return
            }
//            if GIDSignIn.sharedInstance().hasAuthInKeychain() & System.userName != nil {
//                System.userName = getUsername(email: user.profile.email)
//                window?.rootViewController = TabBarViewController()
//            } else {
            System.userName = getUsername(email: user.profile.email)
//          WHY IS THIS NOT RUNNING AS EXPECTED
            NetworkManager.getUserByNetId(netId: System.userName ?? "") { user in
                DispatchQueue.main.async {
                    System.user = user[0]
                }
            }
            window?.rootViewController = SignUpViewController()
            
            
        }
    
        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                print(error.localizedDescription)
                return
            }
            System.userName = nil
//            System.chats.removeAll()
        }
    
        func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
    
    static let bigRed: UIColor = UIColor(red: 179.0/255.0, green: 27.0/255.0, blue: 27.0/255.0, alpha: 1.0)
    static let brightRed: UIColor = UIColor(red: 1, green: 0.1961, blue: 0.1961, alpha: 1.0)
}
