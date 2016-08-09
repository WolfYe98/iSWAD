//
//  DetailViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit

class CoursesDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

	@IBOutlet var subjectDetailTable: UITableView!
	

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if self.detailDescriptionLabel != nil {
				self.title = detail.description
				var optionsSubject:[String] = []
				optionsSubject.append("Documentos")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	
	@IBAction func onTouchNotifications(sender: AnyObject) {
		print("Touch on Notif")
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyboard.instantiateViewControllerWithIdentifier("NotificationsView") as! UISplitViewController
		vc.minimumPrimaryColumnWidth = 0
		vc.maximumPrimaryColumnWidth = 600
		vc.preferredPrimaryColumnWidthFraction = 0.6
		let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
		navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem()
		let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
		appDelegate.window!.rootViewController = vc
		
		let rightNavController = vc.viewControllers.last as! UINavigationController
		let detailViewController = rightNavController.topViewController as! NotificationsDetailViewController
		let leftNavController = vc.viewControllers.first as! UINavigationController
		let masterViewController = leftNavController.topViewController as! NotificationsMasterViewController
		masterViewController.getNotifications()
		
		sleep(1)

		let firstNot = masterViewController.notificationsList.first
		detailViewController.detailItem = firstNot
		detailViewController.configureView()
		
	}

}

