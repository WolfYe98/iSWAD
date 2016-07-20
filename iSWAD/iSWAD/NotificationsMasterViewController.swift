//
//  NotificationsMasterViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 13/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import SWXMLHash
import FontAwesome_swift

class notification {
	var id = String()
	var content = String()
	var type = String()
	var summary = String()
	var date = String()
	var location = String()
	var from = String()
	var icono = String()
	var userPhoto = String()
	var unread = Bool()
}

class cellNotification: UITableViewCell{
	//@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var from: UILabel!
	@IBOutlet weak var type: UILabel!
	@IBOutlet weak var subject: UILabel!
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var summary: UILabel!
	@IBOutlet weak var icono: UILabel!
	
}

class NotificationsMasterViewController: UITableViewController {
	
	private var collapseDetailViewController = true

	var notificationsList:[notification] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Notificaciones"
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
		if notificationsList[indexPath.row].unread {
				cell.backgroundColor = UIColor .cyanColor()
		}
		
		cell.icono.font = UIFont.fontAwesomeOfSize(50)
		cell.icono.text = String.fontAwesomeIconWithCode(notificationsList[indexPath.row].icono)
		
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
					noti.type = "Inscripción"
					noti.content = "Has sido ingresado como estudiante en la asignatura "+(item["location"].element?.text)!
					noti.icono = "fa-user-plus"
				case Constants.notificationType.enrollmentTeacher.rawValue:
					noti.type = "Inscripción"
					noti.content = "Has sido ingresado como profesor en la asignatura "+(item["location"].element?.text)!
					noti.icono = "fa-graduation-cap"
				case Constants.notificationType.message.rawValue:
					noti.type = "Mensaje"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-envelope"
				case Constants.notificationType.examAnnouncement.rawValue:
					noti.type = "Convocatoria de examen"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-check-square-o"
				case Constants.notificationType.notice.rawValue:
					noti.type = "Aviso"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-bullhorn"
				case Constants.notificationType.assignment.rawValue:
					noti.type = "Actividad"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-pencil"
				case Constants.notificationType.documentFile.rawValue:
					noti.type = "Documento"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-file-text"
				case Constants.notificationType.teachersFile.rawValue:
					noti.type = "Documento de profesor"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				case Constants.notificationType.sharedFile.rawValue:
					noti.type = "Documento compartido"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				case Constants.notificationType.marksFile.rawValue:
					noti.type = "Calificaciones"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				case Constants.notificationType.enrollmentRequest.rawValue:
					noti.type = "Petición de inscripción"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				case Constants.notificationType.timelineComment.rawValue:
					noti.type = "Comentario"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-commenting"
				case Constants.notificationType.timelineFav.rawValue:
					noti.type = "Favorito"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-star"
				case Constants.notificationType.timelineShare.rawValue:
					noti.type = "Compartido"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-retweet"
				case Constants.notificationType.timelineMention.rawValue:
					noti.type = "Nueva Mención"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-at"
				case Constants.notificationType.follower.rawValue:
					noti.type = "Nuevo seguidor"
					noti.content = (item["userFirstname"].element?.text)!+" "+(item["userSurname1"].element?.text)!+" te ha comenzado a seguir"
					noti.icono = "fa-users"
				case Constants.notificationType.forumPostCourse.rawValue:
					noti.type = "Hebra"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				case Constants.notificationType.forumReply.rawValue:
					noti.type = "Respuesta en el foro"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				case Constants.notificationType.survey.rawValue:
					noti.type = "Cuestionario"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-"
				default:
					noti.type = "Desconocido"
					noti.content = (item["content"].element?.text)!
					noti.icono = "fa-question"
				}
				noti.summary = (item["summary"].element?.text)!
				noti.location = (item["location"].element?.text)!
				noti.userPhoto = (item["userPhoto"].element?.text)!
				print(Int((item["status"].element?.text)!))
				if Int((item["status"].element?.text)!) < 4{
					noti.unread = true
				} else {
					noti.unread = false
				}
				
				//print(noti.userPhoto)
				//noti.type = (item["eventType"].element?.text)!
				let timeInterval = Double((item["eventTime"].element?.text)!)

				let date = NSDate(timeIntervalSince1970: timeInterval!)
				let formatter = NSDateFormatter()
				formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
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