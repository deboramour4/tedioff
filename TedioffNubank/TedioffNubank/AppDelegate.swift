//
//  AppDelegate.swift
//  TedioffNubank
//
//  Created by Débora Oliveira on 03/09/19.
//  Copyright © 2019 Débora Oliveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // FIXME: Just a variable to simulate the change of status
    static var status = PublishSubject<ViewStatus>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = Controller(status: AppDelegate.status)
        
        AppDelegate.status.onNext(.empty)
        
        let navControl = UINavigationController(rootViewController: controller.viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navControl
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TedioffNubank")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

