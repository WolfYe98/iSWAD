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
	
	var courseInformation: String = ""
	var courseGuide: String = ""
	var courseLectures: String = ""
	var coursePracticals: String = ""
	var courseBibliography: String = ""
	var courseFAQ: String = ""
	var courseLinks: String = ""
	var courseAssessment: String = ""
	var courseCode: Int = 0
	
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
			self.courseCode = detail.code
			getCourseInfo(self.courseCode, infoType: "introduction")
			getCourseInfo(self.courseCode, infoType: "guide")
			getCourseInfo(self.courseCode, infoType: "lectures")
			getCourseInfo(self.courseCode, infoType: "practicals")
			getCourseInfo(self.courseCode, infoType: "bibliography")
			getCourseInfo(self.courseCode, infoType: "FAQ")
			getCourseInfo(self.courseCode, infoType: "links")
			getCourseInfo(self.courseCode, infoType: "assessment")
			
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
		optionsForSubject[0].append(Option(name: "Introducción", image: "fa-info", segue: "introduction"))
		optionsForSubject[0].append(Option(name: "Guía Docente" , image: "fa-file-text", segue: "guide"))
		optionsForSubject[0].append(Option(name: "Programa de teoría" , image: "fa-list-ol", segue: "lectures"))
		optionsForSubject[0].append(Option(name: "Programa de Prácticas" , image: "fa-flask", segue: "practicals"))
		optionsForSubject[0].append(Option(name: "Documentos" , image: "fa-folder-open", segue: ""))
		optionsForSubject[0].append(Option(name: "Archivos compartidos" , image: "fa-folder-open", segue: ""))
		optionsForSubject[0].append(Option(name: "Bibliografia" , image: "fa-book", segue: "bibliography"))
		optionsForSubject[0].append(Option(name: "FAQs" , image: "fa-question", segue: "FAQ"))
		optionsForSubject[0].append(Option(name: "Enlaces" , image: "fa-link", segue: "links"))
		optionsForSubject[1].append(Option(name: "Sistema de Evaluación" , image: "fa-info", segue: "assessment"))
		optionsForSubject[1].append(Option(name: "Tests" , image: "fa-check-square-o", segue: ""))
		optionsForSubject[1].append(Option(name: "Calificaciones" , image: "fa-list-alt", segue: ""))
		optionsForSubject[2].append(Option(name: "Grupos" , image: "fa-sitemap", segue: ""))
		optionsForSubject[2].append(Option(name: "Generar código QR" , image: "fa-qrcode", segue: ""))
		optionsForSubject[2].append(Option(name: "Pasar list" , image: "fa-check-square-o", segue: ""))
		
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
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		
		switch segue.identifier!{
		case "configuration":
			break
		case "introduction":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseInformation
			break
			
		case "guide":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseGuide
			break
			
		case "lectures":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseLectures
			break
			
		case "practicals":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = coursePracticals
			break
			
		case "bibliography":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseBibliography
			break
			
		case "FAQ":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseFAQ
			break
			
		case "links":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseLinks
			break
			
		case "assessment":
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseAssessment
			break
			
		default:
			
			let destinationVC = segue.destinationViewController as! InfoViewController
			destinationVC.info = courseInformation
			break
			
		}
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if optionsForSubject[indexPath.section][indexPath.row].segue != "" {
			performSegueWithIdentifier(optionsForSubject[indexPath.section][indexPath.row].segue, sender: nil)
		}
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
	
	func getCourseInfo(courseCode: Int, infoType: String) -> Void {
		let client = SyedAbsarClient()
		let defaults = NSUserDefaults.standardUserDefaults()
		let requestInfo = GetCourseInfo()
		requestInfo.cpWsKey = defaults.stringForKey(Constants.wsKey)
		requestInfo.cpCourseCode = courseCode
		requestInfo.cpInfoType = infoType
		client.opGetCourseInfo(requestInfo){ (error, response3) in
			switch infoType{
			case "introduction":
				self.courseInformation = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "guide":
				self.courseGuide = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "lectures":
				self.courseLectures = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "practicals":
				self.coursePracticals = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "bibliography":
				self.courseBibliography = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "FAQ":
				self.courseFAQ = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "links":
				self.courseLinks = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			case "assessment":
				self.courseAssessment = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
			default:
				self.courseGuide = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text!)!
				break
				
			}
			
		}
	}
	
}

