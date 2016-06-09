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
		if defaults.boolForKey(Constants.logged) {
			let alertController = UIAlertController(title: "iSWAD", message:
				"Login Correct!", preferredStyle: UIAlertControllerStyle.Alert)
			alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
			
			self.presentViewController(alertController, animated: true, completion: {
				
				self.performSegueWithIdentifier("backToSplit", sender: nil)
			})
		}
		
	}
	
	
	func loginToServer() -> Void {
		let client = SyedAbsarClient()
		let request = LoginByUserPasswordKey()
		let defaults = NSUserDefaults.standardUserDefaults()
		request.cpAppKey = Constants.appKey
		request.cpUserID = defaults.stringForKey(Constants.userIDKey)
		request.cpUserPassword = encryptPassword(defaults.stringForKey(Constants.userPassworKey)!)
		print("Start Login")
		client.opLoginByUserPasswordKey(request) { (error: NSError?, response: XMLIndexer?) in //FUNCIONA!!! TODO: CAMBIAR TODAS LAS FUNCIONES
			let loginData = response!["loginByUserPasswordKeyOutput"]
			print(loginData)
			defaults.setBool(true, forKey: Constants.logged)
			
			defaults.setObject(loginData["wsKey"].element?.text, forKey: "wsKey")
			
			
			/*
			print("Start get Courses")
			//let requestCourses = GetCourses()
			client.opGetCourses(requestCourses){ (error, response2: XMLIndexer?) in
			print(response2)
			print(response2!["getCoursesOutput"]["numCourses"].element?.text)
			let coursesArray = response2!["getCoursesOutput"]["coursesArray"].children
			print(coursesArray)
			for item in coursesArray{
			let courseName = item["courseFullName"].element?.text
			self.objects.insert(courseName!, atIndex: 0)
			let indexPath = NSIndexPath(forRow: 0, inSection: 0)
			self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
			}
			}
			*/
			
			
		}
	}
}