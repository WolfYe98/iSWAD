//
//  LoginViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 05/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash
import ReachabilitySwift

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
	
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	@IBOutlet weak var userID: UITextField!
	
	@IBOutlet var serverPicker: UIPickerView!
	
	@IBOutlet var customServer: UITextField!
	
	let pickerData = ["https://swad.ugr.es/", "https://openswad.org/", "Otro..."]
	
	@IBOutlet weak var userPassword: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		serverPicker.dataSource = self
		serverPicker.delegate = self
		userID.text = defaults.stringForKey(Constants.userIDKey);
		userPassword.text = defaults.stringForKey(Constants.userPassworKey)
		defaults.setObject(pickerData[0], forKey: Constants.serverURLKey)
	}
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count;
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerData[row]
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerData[row] == "Otro..." {
			customServer.hidden = false
		} else {
			customServer.hidden = true
			print(pickerData[row])
			defaults.setObject(pickerData[row], forKey: Constants.serverURLKey)
		}
	}
	
	
	@IBAction func onTouchLogin(sender: AnyObject) {
		
		let reachability: Reachability
		do {
			reachability = try Reachability.reachabilityForInternetConnection()
		} catch {
			print("Unable to create Reachability")
			return
		}
		
		if !reachability.isReachable() {
			let alertController = UIAlertController(title: "iSWAD", message:
				"No se puede conectar a Internet", preferredStyle: UIAlertControllerStyle.Alert)
			alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
			self.presentViewController(alertController, animated: true, completion: {})
			return
		}
		
		
		defaults.setObject(userID.text, forKey: Constants.userIDKey)
		defaults.setObject(userPassword.text, forKey: Constants.userPassworKey)
		var serverString = pickerData[serverPicker.selectedRowInComponent(0)]
		if serverString == "Otro..." {
			serverString = customServer.text!
		}
		print(serverString)
		defaults.setObject(serverString, forKey: Constants.serverURLKey)
		loginToServer()
		sleep(1)
		if defaults.boolForKey(Constants.logged) {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let vc = storyboard.instantiateViewControllerWithIdentifier("CoursesView") as! UISplitViewController
			let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
			navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem()
			let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
			appDelegate.window!.rootViewController = vc
			
		} else {
			
			let alertController = UIAlertController(title: "iSWAD", message:
				"Login Incorrecto!", preferredStyle: UIAlertControllerStyle.Alert)
			alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
			self.presentViewController(alertController, animated: true, completion: {})
		}
		
	}
}

func loginToServer() -> Void {
	print("Start Login")
	let client = SyedAbsarClient()
	let request = LoginByUserPasswordKey()
	let defaults = NSUserDefaults.standardUserDefaults()
	request.cpAppKey = Constants.appKey
	request.cpUserID = defaults.stringForKey(Constants.userIDKey)
	request.cpUserPassword = encryptPassword(defaults.stringForKey(Constants.userPassworKey)!)
	client.opLoginByUserPasswordKey(request) { (error: NSError?, response: XMLIndexer?) in 
		print(error)
		let loginData = response!["loginByUserPasswordKeyOutput"]
		print(loginData)
		if error == nil {
			print("Correct login")
			defaults.setBool(true, forKey: Constants.logged)
		} else {
			print("Bad login")
			defaults.setBool(false, forKey: Constants.logged)
		}
		
		defaults.setObject(loginData[Constants.userFirstnameKey].element?.text, forKey: Constants.userFirstnameKey)
		print("Login data")
		print(loginData[Constants.wsKey])
		defaults.setObject(loginData[Constants.wsKey].element?.text, forKey: Constants.wsKey)
		
	}
}