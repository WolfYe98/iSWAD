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

class LoginViewController: UIViewController {
	
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	@IBOutlet weak var userID: UITextField!
	
	
	@IBOutlet weak var userPassword: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		userID.text = defaults.stringForKey(Constants.userIDKey);
		userPassword.text = defaults.stringForKey(Constants.userPassworKey)
	}
	
	
	@IBAction func onTouchLogin(sender: AnyObject) {
		defaults.setObject(userID.text, forKey: Constants.userIDKey)
		defaults.setObject(userPassword.text, forKey: Constants.userPassworKey)
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
				"Login Incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
			alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
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
	client.opLoginByUserPasswordKey(request) { (error: NSError?, response: XMLIndexer?) in //FUNCIONA!!! TODO: CAMBIAR TODAS LAS FUNCIONES
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