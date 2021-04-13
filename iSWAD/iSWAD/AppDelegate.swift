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
    var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        let reachability = Reachability(hostname: "www.google.es")
        UIApplication.shared.windows.forEach{window in
            if #available(iOS 13.0, *) {
                window.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        }
        defaults.set(Int32(CLong(NSDate().timeIntervalSince1970)), forKey: Constants.time)
        defaults.set(0, forKey: Constants.numNotifications)
        
        
        if reachability?.connection != Optional.none && reachability?.connection.description != "No Connection"{
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
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        defaults.set(false, forKey: Constants.logged)
        defaults.set("",forKey: Constants.wsKey)
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
            
        let defaults = UserDefaults.standard
            
        let _ = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: {timer in
            if defaults.string(forKey: Constants.wsKey) != nil && defaults.bool(forKey: Constants.logged) == true{
                let numNotis = getNotifications()
                if numNotis > 0{
                    throwNotification(numNotis)
                }
                defaults.set(0, forKey: Constants.numNotifications)
            }
        })
        
        bgTask = application.beginBackgroundTask(expirationHandler: {
            // this is the code that fires when iOS ends your background task.
            self.endBackground()
        })
    }
    func endBackground() {
        UIApplication.shared.endBackgroundTask(bgTask)
        bgTask = UIBackgroundTaskInvalid
        print("endBackgroud Callback Method Fired!")
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.endBackground()
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


extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        var options : UNNotificationPresentationOptions = [.alert,.sound]
        if #available(iOS 14.0, *){options = [.list,.banner,.sound]}
        completionHandler(options)
    }
}
