//
//  AppDelegate.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modificated by Adrián Lara Roldán on 07/08/18.
//

import UIKit
import Reachability
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        let reachability = Reachability()
        
        if reachability?.connection != .none {
            defaults.set(nil, forKey: Constants.wsKey)
        }
        
        if (defaults.string(forKey: Constants.wsKey) == nil || defaults.string(forKey: Constants.wsKey) == "") {
            self.window?.rootViewController?.performSegue(withIdentifier: "showLogin", sender: self)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CoursesView") as! UISplitViewController
            let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
            navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem
            
            self.window?.rootViewController = vc
            
            let rightNavController = vc.viewControllers.last as! UINavigationController
            let detailViewController = rightNavController.topViewController as! CoursesDetailViewController
            let leftNavController = vc.viewControllers.first as! UINavigationController
            let masterViewController = leftNavController.topViewController as! CoursesMasterViewController
            masterViewController.getCourses()
            sleep(1)
            let firstCourse = masterViewController.coursesList.first
            detailViewController.detailItem = firstCourse
            detailViewController.configureView()
        }
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
                if !accepted {
                    print("Permiso denegado por el usuario")
                }
            }
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        if #available(iOS 10.0, *) {
            let notifications = getNotifications()
            if notifications > 0{
                
                // 1. Creamos el Trigger de la Notificación
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
                
                // 2. Creamos el contenido de la Notificación
                let content = UNMutableNotificationContent()
                content.title = "Nuevo aviso desde SWAD"
                content.subtitle = ""
                content.body = "Tiene \(notifications) notificaciones nuevas en SWAD"
                content.sound = UNNotificationSound.default()
                content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
                
                // 3. Creamos la Request
                let request = UNNotificationRequest(identifier: "SWADNotification", content: content, trigger: trigger)
                
                // 4. Añadimos la Request al Centro de Notificaciones
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                UNUserNotificationCenter.current().add(request) {(error) in
                    if let error = error {
                        print("Se ha producido un error: \(error)")
                    }
                }
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        defaults.set(false, forKey: Constants.logged)
    }
    
    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? CoursesDetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}


