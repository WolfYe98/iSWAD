//
//  NotificationsMasterViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 13/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import SWXMLHash




class notification {
	var id = String()
	var content = String()
	var type = String()
	var summary = String()
	var date = String()
	var location = String()
	var from = String()
}

class cellNotification: UITableViewCell{
	//@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var from: UILabel!
	@IBOutlet weak var type: UILabel!
	@IBOutlet weak var subject: UILabel!
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var summary: UILabel!
	
}

class NotificationsMasterViewController: UITableViewController {
	
	private var collapseDetailViewController = true

	var notificationsList:[notification] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = NSUserDefaults.standardUserDefaults().stringForKey(Constants.userFirstnameKey)
		self.tableView.dataSource = self;
		getNotifications()
	}
	//MARK: Table View Data Source and Delegate
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notificationsList.count
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cellNotifications", forIndexPath: indexPath) as! cellNotification
		cell.type.text = notificationsList[indexPath.row].type
		cell.summary.text = notificationsList[indexPath.row].summary
		cell.subject.text = notificationsList[indexPath.row].location
		cell.date.text = notificationsList[indexPath.row].date
		cell.from.text = notificationsList[indexPath.row].from
		return cell
	}
	

	
	// MARK: - Segues
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showNotification" {
			self.splitViewController?.toggleMasterView()
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let object = notificationsList[indexPath.row]
				let controller = (segue.destinationViewController as! UINavigationController).topViewController as! NotificationsDetailViewController
				controller.detailItem = object
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}
	}
	
	func getNotifications() -> Void {
		print("Start get Notifications")
		
		let client = SyedAbsarClient()
		let defaults = NSUserDefaults.standardUserDefaults()
		let requestNotifications = GetNotifications()
		requestNotifications.cpWsKey = defaults.stringForKey(Constants.wsKey)
		requestNotifications.cpBeginTime = 0
		client.opGetNotifications(requestNotifications){ (error, response: XMLIndexer?) in
			//print(response)
			let notificationsArray = response!["getNotificationsOutput"]["notificationsArray"].children
			print(notificationsArray)
			for item in notificationsArray{
				let noti = notification()
				noti.id = (item["notifCode"].element?.text)!
				switch (item["eventType"].element?.text)! {
				case Constants.notificationType.enrollmentStudent.rawValue:
					noti.type = "Estudiante"
					noti.content = "Has sido ingresado como estudiante en la asignatura "+(item["location"].element?.text)!
				case Constants.notificationType.enrollmentTeacher.rawValue:
					noti.type = "Professor"
					noti.content = "Has sido ingresado como estudiante en la asignatura "+(item["location"].element?.text)!
				case Constants.notificationType.message.rawValue:
					noti.type = "Mensaje"
					noti.content = (item["content"].element?.text)!
				default:
					noti.type = "Desconocido"
					noti.content = (item["content"].element?.text)!
				}
				noti.summary = (item["summary"].element?.text)!
				noti.location = (item["location"].element?.text)!
				noti.type = (item["eventType"].element?.text)!
				let timeInterval = Double((item["eventTime"].element?.text)!)

				let date = NSDate(timeIntervalSince1970: timeInterval!)
				let formatter = NSDateFormatter()
				formatter.dateStyle = NSDateFormatterStyle.LongStyle
				formatter.timeStyle = .MediumStyle
				
				let dateString = formatter.stringFromDate(date)
				
				noti.date = dateString
				noti.from = (item["userFirstname"].element?.text)!+" "+(item["userSurname1"].element?.text)!

				self.notificationsList.append(noti)
			}
			// We have to send the reloadData to the UIThread otherwise won't be instant
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
			print(self.notificationsList)
		}
	}
}