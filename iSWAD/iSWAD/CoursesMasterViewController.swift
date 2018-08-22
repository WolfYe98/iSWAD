//
//  CoursesMasterViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//

import UIKit
import SWXMLHash

class CoursesMasterViewController: UITableViewController {
    @IBOutlet var notifiButton: UIButton!
    @IBOutlet var configButton: UIBarButtonItem!
    var coursesList:[Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Asignaturas"
        self.tableView.dataSource = self;
        if self.coursesList.isEmpty {
            getCourses()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.notifiButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
        self.notifiButton.setTitle(String.fontAwesomeIcon(name: .bell), for: .normal)
        self.notifiButton.setTitleColor(UIColor.black, for: UIControlState())
        self.notifiButton.setTitleColor(UIColor.blue, for: .highlighted)
        let attributes = [NSAttributedStringKey.font: UIFont.fontAwesome(ofSize: 25)] as Dictionary?
        configButton.setTitleTextAttributes(attributes, for: .normal)
        configButton.tintColor = UIColor.black
        configButton.title = String.fontAwesomeIcon(name: .cogs)
    }
    
    class  Course: Any {
        var name: String = ""
        var code: Int = 0
    }
    
    //MARK: Table View Data Source and Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = coursesList[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Segues
    /*!
     Segue for navigate to the details of the course
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            self.splitViewController?.toggleMasterView()
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = coursesList[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! CoursesDetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    /*!
     Function that loads all the courses for the logged student
     */
    func getCourses() -> Void {
        let client = SyedAbsarClient()
        let defaults = UserDefaults.standard
        
        let requestCourses = GetCourses()
        requestCourses.cpWsKey = defaults.string(forKey: Constants.wsKey)
        
        client.opGetCourses(requestCourses){ (error, response2: XMLIndexer?) in
            let coursesArray = response2!["getCoursesOutput"]["coursesArray"].children
            for item in coursesArray{
                let course = Course()
                course.name = (item["courseShortName"].element?.text)!
                course.code = Int((item["courseCode"].element?.text)!)!
                self.coursesList.append(course)
            }
            // We have to send the reloadData to the UIThread otherwise won't be instant
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    /**
     method that collects the event by tapping on the icon of the notifications and loads the corresponding view
    */
    @IBAction func onTouchNotifications(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NotificationsView") as! UISplitViewController
        vc.preferredDisplayMode = UISplitViewControllerDisplayMode.primaryOverlay
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc
    }
}
