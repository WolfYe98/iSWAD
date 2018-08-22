//
//  ConfigurationViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//

import UIKit
import Foundation
import SWXMLHash
import SQLite3

class ConfigurationViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet var messagesPicker: UIPickerView!
    let pickerData = ["1 dia", "1 semana", "1 mes", "1 año", "1 minuto"]
    let defaults = UserDefaults.standard
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesPicker.dataSource = self
        messagesPicker.delegate = self
    }
    
    /**
        This method that establishes from when the notifications are displayed in the notifications section of the app
     
        ### Important Notes ###
        The time is established through the time selected in the PickerView enabled for it, after clicking on the OK button, the database is updated with the new selected time
    */
    @IBAction func setTime(_ sender: Any) {
        /// Constant with the time provided by the PickerView
        let timeSelected = pickerData[messagesPicker.selectedRow(inComponent: 0)]
        
        /// Global variable of the database
        db = openDatabase()
        
        switch timeSelected {
        case "1 dia":
            update(since:3600*24)
            break
        case "1 semana":
            update(since:3600*24*7)
            break
        case "1 mes":
            update(since:3600*24*30)
            break
        case "1 año":
            update(since:3600*24*365)
            break
        case "1 minuto":
            update(since:60)
            break
        default:
            break
        }
    }
    
    /**
        Method to close the session in the app
     
     ### Important notes ###
     This method clears the session key in swad
    */
    @IBAction func onTouchLogout(_ sender: AnyObject) {
        defaults.set("", forKey: Constants.wsKey)
        exit(1)
    }
    
    /**
        Method to open the connection to the database
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
        This method updates the tuple with name periode by setting the value field to the selected new time
    */
    func update(since: Int) {
        /// String with the update statement
        let updateStatementString = "UPDATE swad SET value = \(since) WHERE name = 'periode'"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                let alertController = UIAlertController(title: "iSWAD", message:"Valor actualizado correctamente!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: {(alert: UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alertController, animated: true, completion: {        })
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
}
