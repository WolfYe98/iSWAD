//
//  CoursesMasterViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 13/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import SWXMLHash

class CoursesMasterViewController: UITableViewController {
 
	var coursesList:[Course] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Asignaturas"
		self.tableView.dataSource = self;
		if self.coursesList.isEmpty {
			getCourses()
		}
	}
	
	class  Course: AnyObject {
		var name: String = ""
		var code: Int = 0
	}
	
	//MARK: Table View Data Source and Delegate
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return coursesList.count
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
		cell.textLabel?.text = coursesList[indexPath.row].name
		return cell
	}
	
	// MARK: - Segues
	/*!
		Segue for navigate to the details of the course
	*/
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showDetail" {
			self.splitViewController?.toggleMasterView()
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let object = coursesList[indexPath.row]
				let controller = (segue.destinationViewController as! UINavigationController).topViewController as! CoursesDetailViewController
				controller.detailItem = object
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}
	}
	
	
	/*!
		Function that loads all the courses for the logged student
	*/
	func getCourses() -> Void {
		print("Start get Courses")
		
		let client = SyedAbsarClient()
		let defaults = NSUserDefaults.standardUserDefaults()
		let requestCourses = GetCourses()
		print(defaults.stringForKey(Constants.wsKey))
		requestCourses.cpWsKey = defaults.stringForKey(Constants.wsKey)
		client.opGetCourses(requestCourses){ (error, response2: XMLIndexer?) in
			print(response2)
			print(response2!["getCoursesOutput"]["numCourses"].element?.text)
			let coursesArray = response2!["getCoursesOutput"]["coursesArray"].children
			print(coursesArray)
			for item in coursesArray{
				let course = Course()
				course.name = (item["courseFullName"].element?.text)!
				course.code = Int((item["courseCode"].element?.text)!)!
				self.coursesList.append(course)
			}
			// We have to send the reloadData to the UIThread otherwise won't be instant
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
			print(self.coursesList)
		}
	}
}