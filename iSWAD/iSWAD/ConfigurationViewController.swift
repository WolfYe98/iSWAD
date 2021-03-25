//
//  ConfigurationViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//
//  Modified by Bate Ye on 18/03/2021

import UIKit
import Foundation
import SWXMLHash
import SQLite3

class ConfigurationViewController: UIViewController {

    let defaults = UserDefaults.standard
    var imagen : UIImage!
    let pickerData = ["1 dia", "1 semana", "1 mes", "1 año", "1 minuto"]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var durationPickerView: UIPickerView!
    
    @IBOutlet weak var okbton: UIButton!
    
    @IBOutlet weak var exitBton: UIButton!
    
    @IBOutlet weak var logoutbton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Configuration"
        // Do any additional setup after loading the view.
        self.userIdLabel.adjustsFontSizeToFitWidth = true
        self.durationPickerView.dataSource = self
        self.durationPickerView.delegate = self
        loadDatos()
        okbton.layer.cornerRadius = 20
        exitBton.layer.cornerRadius = 20
        logoutbton.layer.cornerRadius = 20
    }
    
    
    @IBAction func okButtonSetTime(_ sender: Any) {
        let timeSelected = pickerData[durationPickerView.selectedRow(inComponent: 0)]
        
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
    
    // This take us to the loginViewController
    @IBAction func logOutButton(_ sender: Any) {
        defaults.removeObject(forKey: Constants.userPhotoKey)
        defaults.set("",forKey: Constants.wsKey)
        defaults.set(false,forKey: Constants.logged)
        navigationController?.viewControllers.removeAll()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "navigation") as! UINavigationController
        navController.viewControllers.removeAll()
        let vc = storyboard.instantiateViewController(withIdentifier: "Login")
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc
    }
    
    //This action will get out of the app
    @IBAction func salirButton(_ sender: Any) {
        defaults.set("",forKey: Constants.wsKey)
        defaults.removeObject(forKey: Constants.userPhotoKey)
        defaults.set("",forKey: Constants.wsKey)
        defaults.set(false,forKey: Constants.logged)
        exit(1)
    }
    
    
    func loadDatos(){
        // We try to load the image from the URL, if it doesn't have any value, we load a local image.
        if defaults.string(forKey: Constants.userPhotoKey) != nil{
            let photoURL = URL(string: defaults.string(forKey: Constants.userPhotoKey)!)
            if photoURL != nil{
                if let datos = try? Data(contentsOf: photoURL!){
                    if let imagen = UIImage(data: datos){
                        DispatchQueue.main.async {
                            self.imageView.image = imagen
                        }
                    }
                }
            }
        }
        else{
            imagen = UIImage(named: "nouser")
            if imagen != nil{
                imageView.image = imagen
            }
        }
        if defaults.string(forKey: Constants.userNickNameKey) != nil{
            self.userIdLabel.text = "@" + defaults.string(forKey: Constants.userNickNameKey)!
        }
        else{
            self.userIdLabel.text = defaults.string(forKey: Constants.userIDKey)
        }
        
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



// Extension of ConfigViewController to the UIPickerViewDataSource and to the UIPickerViewDelegate protocols for asign values to the pickerView

extension ConfigurationViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
