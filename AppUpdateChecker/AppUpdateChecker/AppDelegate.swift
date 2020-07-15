//
//  AppDelegate.swift
//  AppUpdateChecker
//
//  Created by Jayesh Mardiya on 15/07/20.
//  Copyright © 2020 Jayesh Mardiya. All rights reserved.
//

import UIKit
import CoreData
import LaunchGate

let appstoreLink = "https://itunes.apple.com/app/id1499323695"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var launchGate: LaunchGate? = {
      let launchGate = LaunchGate(
        configURI: "https://github.com/JayeshMardiya/JamesDemo/blob/master/example.json?raw=true",
        appStoreURI: appstoreLink
      )
      
      // If you need to use a custom config file structure,
      // you can create a default parser that conforms to LaunchGateParser:
      //
      // launchGate?.parser = MyCustomParser()
      
      return launchGate
    }()
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        launchGate?.check()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "UpdateApp")
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

