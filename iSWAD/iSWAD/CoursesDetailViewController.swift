//
//  CoursesDetailViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import SwiftSpinner

class cellOption: UITableViewCell{
	
	@IBOutlet var option: UILabel!
	
	@IBOutlet var icon: UILabel!
	
}


class CoursesDetailViewController: UITableViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

	@IBOutlet var subjectDetailTable: UITableView!
	
	@IBOutlet var notifiButton: UIButton!
	
	@IBOutlet var configButton: UIBarButtonItem!
	
	
	var sectionTitles:[String] = ["Asignatura", "Evaluación", "Usuarios"]
	
	/// Class for string the options for each subject
	class Option: AnyObject {
		var name: String = ""
		var segue: String = ""
		var image: String = ""
		
		init (name: String, image: String, segue: String){
			self.name = name
			self.image = image
			self.segue = segue
		}
	}
	
	var optionsForSubject = [[Option]]()
	
    var detailItem: AnyObject? {
        didSet(detailItem) {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem as? CoursesMasterViewController.Course {
			print("Detail")
			print(detail)
			self.title = detail.name
        }
    }
	
	//MARK: Table View Data Source and Delegate
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return optionsForSubject.count
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return optionsForSubject[section].count
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cellSubject", forIndexPath: indexPath) as! cellOption
		
		cell.option.text = optionsForSubject[indexPath.section][indexPath.row].name
		cell.icon.font = UIFont.fontAwesomeOfSize(22)
		cell.icon.text = String.fontAwesomeIconWithCode(optionsForSubject[indexPath.section][indexPath.row].image)
		
		return cell
	}
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionTitles[section]
	}


    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
	
	override func loadView() {
		super.loadView()
		
		
		optionsForSubject.append([])
		optionsForSubject.append([])
		optionsForSubject.append([])
		optionsForSubject[0].append(Option(name: "Introducción", image: "fa-info", segue: "information"))
		optionsForSubject[0].append(Option(name: "Guía Docente" , image: "fa-file-text", segue: "guide"))
		optionsForSubject[0].append(Option(name: "Programa de teoría" , image: "fa-list-ol", segue: "theory"))
		optionsForSubject[0].append(Option(name: "Programa de Prácticas" , image: "fa-flask", segue: "practices"))
		optionsForSubject[0].append(Option(name: "Documentos" , image: "fa-folder-open", segue: "documents"))
		optionsForSubject[0].append(Option(name: "Archivos compartidos" , image: "fa-folder-open", segue: "shared"))
		optionsForSubject[0].append(Option(name: "Bibliografia" , image: "fa-book", segue: "bibliography"))
		optionsForSubject[0].append(Option(name: "FAQs" , image: "fa-question", segue: "faqs"))
		optionsForSubject[0].append(Option(name: "Enlaces" , image: "fa-link", segue: "links"))
		optionsForSubject[1].append(Option(name: "Sistema de Evaluación" , image: "fa-info", segue: "evaluation"))
		optionsForSubject[1].append(Option(name: "Tests" , image: "fa-check-square-o", segue: "tests"))
		optionsForSubject[1].append(Option(name: "Calificaciones" , image: "fa-list-alt", segue: "grades"))
		optionsForSubject[2].append(Option(name: "Grupos" , image: "fa-sitemap", segue: "groups"))
		optionsForSubject[2].append(Option(name: "Generar código QR" , image: "fa-qrcode", segue: "qrcode"))
		optionsForSubject[2].append(Option(name: "Pasar list" , image: "fa-check-square-o", segue: "checklist"))
		
		self.notifiButton.titleLabel?.font = UIFont.fontAwesomeOfSize(25)
		self.notifiButton.setTitle(String.fontAwesomeIconWithName(.Bell), forState: .Normal)
		self.notifiButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
		self.notifiButton.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
		
		let attributes = [NSFontAttributeName: UIFont.fontAwesomeOfSize(25)] as Dictionary!
		configButton.setTitleTextAttributes(attributes, forState: .Normal)
		configButton.tintColor = UIColor.blackColor()
		configButton.title = String.fontAwesomeIconWithName(.Cogs)

	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		print(optionsForSubject[indexPath.section][indexPath.row].segue)
		performSegueWithIdentifier(optionsForSubject[indexPath.section][indexPath.row].segue, sender: nil)
	}
	
	@IBAction func onTouchNotifications(sender: AnyObject) {
		print("Touch on Notif")
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("NotificationsView") as! UISplitViewController
		vc.minimumPrimaryColumnWidth = 0
		vc.maximumPrimaryColumnWidth = 600
		vc.preferredPrimaryColumnWidthFraction = 0.6
		vc.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryOverlay
		let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
		navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem()
		let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
		
		let rightNavController = vc.viewControllers.last as! UINavigationController
		let detailViewController = rightNavController.topViewController as! NotificationsDetailViewController
		let leftNavController = vc.viewControllers.first as! UINavigationController
		let masterViewController = leftNavController.topViewController as! NotificationsMasterViewController
		
		//SwiftSpinner.show("Connecting to satellite...")
		
		//masterViewController.getNotifications()
		//sleep(1)
		
		//let firstNot = masterViewController.notificationsList.first
		//detailViewController.detailItem = firstNot
		//detailViewController.configureView()
		
		
		appDelegate.window!.rootViewController = vc
		
		//SwiftSpinner.hide()
		
	}
	
	/*!
	Function that get the information given a course and the type of information you want
	
	- parameter courseCode:	code that identifies the course
	- parameter infoType:		type of information that you want from the course
	
	- returns: <#return value description#>
	*/
	
	func getCourseInfo(courseCode: Int, infoType: String) -> String {
		let client = SyedAbsarClient()
		let defaults = NSUserDefaults.standardUserDefaults()
		let requestInfo = GetCourseInfo()
		requestInfo.cpWsKey = defaults.stringForKey(Constants.wsKey)
		requestInfo.cpCourseCode = 1
		var responseForReturn = ""
		client.opGetCourseInfo(requestInfo){ (error, response) in
			responseForReturn = "Hola"
		}
		return responseForReturn
	}

}

