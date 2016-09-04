//
//  NotificationsDetailViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import SWXMLHash

class NotificationsDetailViewController: UIViewController {
	
	@IBOutlet var subjectsButton: UIButton!
	
	@IBOutlet var notificationsContent: UITextView!
	
	@IBOutlet var personImage: UIImageView!
	
	@IBOutlet var from: UILabel!
	
	@IBOutlet var subject: UILabel!
	
	@IBOutlet var summary: UILabel!
	
	@IBOutlet var date: UILabel!
	
	@IBOutlet var toolbar: UIToolbar!
	
	var detailItem: AnyObject? {
		didSet(detailItem) {
			self.configureView()
		}
	}

	func configureView() {
		if let detail = self.detailItem {
			if self.notificationsContent != nil {
				
				var not = notification()
				not = detail as! notification
				self.notificationsContent.text = not.content.html2String
				self.notificationsContent.font = UIFont(name: "Helvetica", size: 20)
				self.from.text = not.from
				self.subject.text = not.location
				self.date.text = not.date
				self.summary.text = not.summary
				let url = NSURL(string: not.userPhoto)
				
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
					let data = NSData(contentsOfURL: url!) 
					dispatch_async(dispatch_get_main_queue(), {
						self.personImage.image = UIImage(data: data!)
					});
				}

				self.title = not.type
				
				if not.type == "Mensaje" {
					let answerButton = UIBarButtonItem(title: "Responder", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NotificationsDetailViewController.onTouchAnswer(_:)))
					let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
					toolbar.items = [flexibleSpace, flexibleSpace, answerButton]
				}
				
				
				let client = SyedAbsarClient()
				let defaults = NSUserDefaults.standardUserDefaults()
				let requestReadNotification = MarkNotificationsAsRead()
				requestReadNotification.cpWsKey = defaults.stringForKey(Constants.wsKey)
				requestReadNotification.cpNotifications = not.id
				client.opMarkNotificationsAsRead(requestReadNotification){(error, response2: XMLIndexer?) in
					print(response2)
				}

			}
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		
		let destinationVC = segue.destinationViewController as! MessagesViewController
		destinationVC.contentFromNotification = detailItem
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureView()
	}
	
	override func viewDidAppear(animated: Bool) {
		
		
	}
	
	
	override func loadView() {
		super.loadView()
		
		self.subjectsButton.titleLabel?.font = UIFont.fontAwesomeOfSize(25)
		self.subjectsButton.setTitle(String.fontAwesomeIconWithName(.FolderOpen), forState: .Normal)
		self.subjectsButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
		self.subjectsButton.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func onTouchAnswer(sender: AnyObject){
		performSegueWithIdentifier("showAnswer", sender: nil)
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

