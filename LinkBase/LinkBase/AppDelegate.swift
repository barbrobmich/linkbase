//
//  AppDelegate.swift
//  LinkBase
//
//  Created by Rob Hernandez on 3/20/17.
//  Copyright © 2017 barbrobmich. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var challengeGame: ScoreCard?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        challengeGame = ScoreCard(playerName: "Lisa") // once user model is created, we should input the username instead

		Parse.initialize(
			with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) in
				configuration.applicationId = "linkbase"
                configuration.clientKey = "fasfsaf0-isa9f898f09809f80sa809fsd9a"
				configuration.server = "https://barbrobmich.herokuapp.com/parse"
			})
		)
        
        Affiliation.registerSubclass()
        Project.registerSubclass()
        LanguageCollection.registerSubclass()
        
        if User.current() != nil {
            
            print("There is a current user with username \(User.current()!.username!)")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Company", bundle: nil) // change to "Login" after removing setup
            // change to Main for team submission
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "CompanyTabBarController") as! UITabBarController
            // change to setup for team submission
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        } else {
            print("There is no current user")
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Login", bundle: nil) // change to "Login" after removing setup VC
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login") // change to "Profile after removing setupVC
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()

        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: User.userDidLogout), object: nil, queue: OperationQueue.main, using: { (NSNotification) -> Void in
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        })
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: User.userDidLogIn), object: nil, queue: OperationQueue.main, using: { (NSNotification) -> Void in
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ProfileSetup")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()

        })

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: User.userDidSignUp), object: nil, queue: OperationQueue.main, using: { (NSNotification) -> Void in
            print("In notification center")
            if self.window?.rootViewController != nil {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
               	let initialViewController = storyboard.instantiateViewController(withIdentifier: "ProfileSetup")
//                let controller = storyboard.instantiateViewControllerWithIdentifier("HomeVC")
                //navigationController!.pushViewController("ProfileSetup")
                
              self.window?.rootViewController = initialViewController
                 self.window?.makeKeyAndVisible()
            }
        })


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


}
