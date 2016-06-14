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
 
	var orderList:[String] = ["a","b","c","d"]
	var coursesList:[String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getCourses()
		print(coursesList)
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
		cell.textLabel?.text = coursesList[indexPath.row]
		return cell
	}
	
	func getCourses() -> Void {
		print("Start get Courses")
		
		let client = SyedAbsarClient()
		let defaults = NSUserDefaults.standardUserDefaults()
		let requestCourses = GetCourses()
		requestCourses.cpWsKey = defaults.stringForKey(Constants.wsKey)
		client.opGetCourses(requestCourses){ (error, response2: XMLIndexer?) in
			print(response2)
			print(response2!["getCoursesOutput"]["numCourses"].element?.text)
			let coursesArray = response2!["getCoursesOutput"]["coursesArray"].children
			print(coursesArray)
			for item in coursesArray{
				let courseName = item["courseFullName"].element?.text
				self.coursesList.append(courseName!)
				// We have to send the reloadData to the UIThread otherwise won't be instant
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					self.tableView.reloadData()
				})
			}
			
		}
	}
}