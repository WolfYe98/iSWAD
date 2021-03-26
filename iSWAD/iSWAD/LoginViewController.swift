//
//  LoginViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//  Modified by Bate Ye on 23/03/2021

import Foundation
import UIKit
import SWXMLHash
import Reachability
import UserNotifications
import SQLite3

var db: OpaquePointer?

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UNUserNotificationCenterDelegate{
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userID: UITextField!
    @IBOutlet var serverPicker: UIPickerView!
    @IBOutlet var customServer: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var logingButton: UIButton!
    
    let pickerData = ["https://swad.ugr.es/", "https://openswad.org/", "Otro..."]
    
    override func viewDidLoad() {
        logingButton.layer.cornerRadius = 5
        super.viewDidLoad()
        serverPicker.dataSource = self
        serverPicker.delegate = self
        
        userID.text = defaults.string(forKey: Constants.userIDKey)
        userPassword.text = defaults.string(forKey: Constants.userPassworKey)
        defaults.set(pickerData[0], forKey: Constants.serverURLKey)
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerData[row] == "Otro..." {
            customServer.isHidden = false
        } else {
            customServer.isHidden = true
            defaults.set(pickerData[row], forKey: Constants.serverURLKey)
        }
    }
    
    @IBAction func onTouchLogin(_ sender: AnyObject) {
        var serverString = pickerData[serverPicker.selectedRow(inComponent: 0)]
        
        if serverString == "Otro..." {
            serverString = customServer.text!
            if serverString == ""{
                serverString = "http://www.google.com"
            }
        }
        
        let reachability = Reachability(hostname:"www.google.com")
        
        if reachability?.connection == .none  || reachability?.connection.description == "No Connection"{
            let alertController = UIAlertController(title: "iSWAD", message:
                "No se puede conectar a Internet", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: nil))
         
            self.present(alertController, animated: true, completion: {})

            return
        }
        
        defaults.set(userID.text, forKey: Constants.userIDKey)
        defaults.set(userPassword.text, forKey: Constants.userPassworKey)
        
        let url = URL(string: serverString)
        var request = URLRequest(url: url!)
        
        ///a first request is made to the server to get the real URL to perform the SOAP requests in case there is any redirection, since it does not follow the redirects, www.swad.ugr.es redirects swad.ugr.es/es in the case from Spain
        request.httpMethod = "GET"
        request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
        
        let task1 = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            if(response != nil){
                serverString = (response?.url?.absoluteString)!
            }else{
                serverString = "https://www.google.com"
            }
        })
        
        task1.resume()
        
        
        let alert = showLoading(message: "Cargando...")
        self.present(alert, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.defaults.set(serverString, forKey: Constants.serverURLKey)
            loginToServer()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            alert.dismiss(animated: true, completion: nil)
            if self.defaults.bool(forKey: Constants.logged) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CoursesView") as! UISplitViewController
                let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
                navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem
                let appDelegate  = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window!.rootViewController = vc
                
                ///////////////////////////////////////////////////////////////////////////////
                // notifications
                ///////////////////////////////////////////////////
                    if #available(iOS 10.0, *) {
                        let notifications = getNotifications()
                        if notifications > 0{
                    
                        // 1. We created the Notification Trigger
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
                    
                        // 2. We create the content of the Notification
                        let content = UNMutableNotificationContent()
                        content.title = "Nuevo aviso desde SWAD"
                        content.subtitle = ""
                        content.body = "Tiene \(notifications) notificaciones nuevas en SWAD"
                        content.sound = UNNotificationSound.default()
                        content.setValue(true, forKey: "shouldAlwaysAlertWhileAppIsForeground")
                    
                        // 3. We create the Request
                        let request = UNNotificationRequest(identifier: "SWADNotification", content: content, trigger: trigger)
                    
                        // 4. We add the Request to the Notifications Center
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        UNUserNotificationCenter.current().add(request) {(error) in
                            if let error = error {
                                print("Se ha producido un error: \(error)")
                            }
                        }
                    }
                }
                /////////////////////////////////////////////////////
            } else {
                showAlert(self, message: "Login Incorrecto", 1, handler: { res in })
            }
        })
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // This one is for going back to here
    @IBAction func unwind(_ seg: UIStoryboard){}
}

func loginToServer() -> Void {
    let client = SyedAbsarClient()
    let request = LoginByUserPasswordKey()
    let defaults = UserDefaults.standard
    
    request.cpAppKey = Constants.appKey
    request.cpUserID = defaults.string(forKey: Constants.userIDKey)
    request.cpUserPassword = encryptPassword(defaults.string(forKey: Constants.userPassworKey)!)
    
    /// the SOAP request login is performed
    client.opLoginByUserPasswordKey(request) { (error: NSError?, response: XMLIndexer?) in
        let loginData = response!["loginByUserPasswordKeyOutput"]
        
        if error == nil {
            defaults.set(true, forKey: Constants.logged)
            defaults.set(loginData[Constants.userFirstnameKey].element?.text, forKey: Constants.userFirstnameKey)
            defaults.set(loginData[Constants.wsKey].element?.text, forKey: Constants.wsKey)
            if loginData[Constants.userPhotoKey].element?.text != nil{
                defaults.set(loginData[Constants.userPhotoKey].element?.text, forKey: Constants.userPhotoKey)
            }
            defaults.set(loginData[Constants.userIDKey].element?.text, forKey: Constants.userIDKey)
            defaults.set(loginData[Constants.userNickNameKey].element?.text,forKey: Constants.userNickNameKey)
        } else {
            defaults.set(false, forKey: Constants.logged)
        }
    }
}

/**
    function that performs the verification of notifications. It checks if there are new notifications not read in the last month
 */
func getNotifications() ->Int{
    //opening the database
    db = openDatabase()
    createTable()
    
    /// the first entry in the database is created in case there is none, otherwise these lines do not perform the insertion
    insert(db: db!, id: 0, name: "time", value: 0)
    insert(db: db!, id: 1, name: "periode", value: 3600*24*30)
    
    var numberOfNotifications = 0
    let client = SyedAbsarClient()
    let defaults = UserDefaults.standard
    let requestNotifications = GetNotifications()
    
    let time = query()
    
    requestNotifications.cpWsKey = defaults.string(forKey: Constants.wsKey)
    requestNotifications.cpBeginTime = time
    client.opGetNotifications(requestNotifications){ (error, response: XMLIndexer?) in
        numberOfNotifications = 0
        
        let notificationsArray = response!["getNotificationsOutput"]["notificationsArray"].children
        
        for item in notificationsArray{
            if Int((item["status"].element?.text)!)! < 4{
                numberOfNotifications += 1
            }
        }
    }
    sleep(1)
    update()
    
    return numberOfNotifications
}

/**
 function to open the connection to the database
 */
func openDatabase() -> OpaquePointer? {
    //the database file
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("swad.sqlite")
    
    var db: OpaquePointer? = nil
    if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
        return db
    } else {
        return nil
    }
}

/**
 function that creates the database if it does not exist
 */
func createTable() {
    let createTableString = "CREATE TABLE IF NOT EXISTS swad (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, value INTEGER)"
    // 1
    var createTableStatement: OpaquePointer? = nil
    // 2
    if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
        // 3
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
            print("Contact table created.")
        } else {
            print("Contact table could not be created.")
        }
    } else {
        print("CREATE TABLE statement could not be prepared.")
    }
    // 4
    sqlite3_finalize(createTableStatement)
}

/**
 function to insert a tuple in the table
 */
func insert(db:OpaquePointer,id:Int, name:String,value:Int) {
    var insertStatement: OpaquePointer? = nil
    let insertStatementString = "INSERT INTO swad (id,name,value) VALUES (?,?,?)"
    
    // 1
    if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
        let id: Int32 = Int32(id)
        let name: NSString = name as NSString
        let value: Int32 = Int32(value)
        
        sqlite3_bind_int(insertStatement, 1, id)
        sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 3, value)
        
        if sqlite3_step(insertStatement) == SQLITE_DONE {
            print("Successfully inserted row.")
        } else {
            print("Could not insert row.")
        }
    } else {
        print("INSERT statement could not be prepared.")
    }
    // 5
    sqlite3_finalize(insertStatement)
}

/**
 function that performs the query to know when was the last time the notifications were consulted
 */
func query() ->Int{
    var time = 0
    let queryStatementString = "SELECT value FROM swad WHERE name = 'time'"
    var queryStatement: OpaquePointer? = nil
    // 1
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        // 2
        if sqlite3_step(queryStatement) == SQLITE_ROW {
            // 3
            time = Int(sqlite3_column_int(queryStatement, 0))
        } else {
            print("Query returned no results")
        }
    } else {
        print("SELECT statement could not be prepared")
    }
    // 6
    sqlite3_finalize(queryStatement)
    
    return time
}

/**
 function that updates the time of the last visit to notifications
 */
func update() {
    let updateStatementString = "UPDATE swad SET value = \(Int32(CLong(NSDate().timeIntervalSince1970))) WHERE name = 'time'"
    var updateStatement: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
    
        if sqlite3_step(updateStatement) == SQLITE_DONE {
            print("Successfully updated row.")
        } else {
            print("Could not update row.")
        }
    } else {
        print("UPDATE statement could not be prepared")
    }
    sqlite3_finalize(updateStatement)
}
