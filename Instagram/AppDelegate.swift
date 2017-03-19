//
//  AppDelegate.swift
//  Instagram
//
//  Created by Ryan Liszewski on 3/5/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "dpoasjflknasklfnaksldnflkd4324234hu42fsdn32"
                configuration.server = "https://shielded-bastion-44951.herokuapp.com/parse"
            })
        )
        
        //If user is already logged in, intiliaze Tab Bar controller
        if(PFUser.current() != nil){
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.window?.rootViewController = tabBarController
        } else {
            let viewController = self.storyboard.instantiateInitialViewController()
            self.window?.rootViewController = viewController
            
        }
        self.window?.makeKeyAndVisible()
        
        //Logout Closure
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"User did Logout"), object: nil, queue: OperationQueue.main) { (Notification) in
            let viewController = self.storyboard.instantiateInitialViewController()
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }

        
        return true
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
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        
//        if(viewController.title == "Post") {
//            tabBarController.present(viewController, animated: true) {
//                UIView.animate(withDuration: 5, animations: {
//                })
//            }
//        }
//        
//        return true
//    }


}

