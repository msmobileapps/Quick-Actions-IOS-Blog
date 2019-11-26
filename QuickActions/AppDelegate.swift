//
//  AppDelegate.swift
//  QuickActions
//
//  Created by Daniel Radshun on 24/11/2019.
//  Copyright © 2019 Daniel Radshun. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var shortcutItemToProcess: UIApplicationShortcutItem?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            shortcutItemToProcess = shortcutItem
        }
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    //Called if the app was still in memory and the shortcut item was triggered
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

        shortcutItemToProcess = shortcutItem
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
                
        if let shortcutItem = shortcutItemToProcess {
            
            var message = ""
                   
            switch shortcutItem.type {
            case "com.msapps.QuickActions.SearchAction":
                message = "Search action was chosen"
            case "com.msapps.QuickActions.AddAction":
                message = "Add action was chosen"
            case "com.msapps.QuickActions.AlarmAction":
                message = "Alarm action was chosen"
            default:
                break
            }
            
            let alertController = UIAlertController(title: "Quick Action Selected", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            DispatchQueue.main.async { [unowned self] in
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            }
                        
            // reset the shortcut item
            shortcutItemToProcess = nil
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        let hours = CurrentTime.shared.hours
        let minutes = CurrentTime.shared.minutes
        let time = "\(hours):\(minutes)"
        application.shortcutItems =
        [UIApplicationShortcutItem(type: "com.msapps.QuickActions.AlarmAction",
                                        localizedTitle: "Set Alarm",
                                        localizedSubtitle: time,
                                        icon: UIApplicationShortcutIcon(type: .alarm),
                                        userInfo: ["Name":"Set Alarm" as NSSecureCoding])]
                
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "QuickActions")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

