//
//  ConfigurationViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 05/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash

class ConfigurationViewController: UIViewController{
	
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func onTouchLogout(sender: AnyObject) {
		defaults.setObject("", forKey: Constants.wsKey)
		exit(1)
	}
}