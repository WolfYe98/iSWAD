//
//  NotificationsDetailViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit

class NotificationsDetailViewController: UIViewController {
	
	@IBOutlet weak var notificationsContent: UILabel!
	
	var detailItem: AnyObject? {
		didSet {
			// Update the view.
			self.configureView()
		}
	}
	

	func configureView() {
		// Update the user interface for the detail item.
		if let detail = self.detailItem {
			if self.notificationsContent != nil {
				var not = notification()
				not = detail as! notification
				self.notificationsContent.text = not.content.html2String
				// Swift
				self.notificationsContent.lineBreakMode = .ByWordWrapping // or NSLineBreakMode.ByWordWrapping
				self.notificationsContent.numberOfLines = 0
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func onTouchSubjects(sender: AnyObject) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("CoursesView") as! UISplitViewController
		vc.minimumPrimaryColumnWidth = 0
		vc.maximumPrimaryColumnWidth = 600
		vc.preferredPrimaryColumnWidthFraction = 0.6
		let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
		navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem()
		let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.window!.rootViewController = vc
	}
}

