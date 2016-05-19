//
//  MasterViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import CryptoSwift

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        loginToServer()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func loginToServer() -> Bool {
        let client = SyedAbsarClient()
        let request = LoginByUserPasswordKey()
        let user = Student()
        user.userID = "26045090"
        request.cpAppKey = "itorres"
        request.cpUserID = "26045090"
        request.cpUserPassword = "hwH1tBXxAE0ffClyQJRwTw-gDnR-fQlRsIj_SfpXM1CQZftvbN8o4fUTccWK1nDUf0dQPmQkhnWPVa-Qsk9mVw"
        var password = "pass"
        password = encryptPassword(password);
        print("Password encryption")
        print("pass1")
        print(password)
        print("pass2")
        print(request.cpUserPassword);
        print("End pass")
        request.cpUserPassword = password
        client.opLoginByUserPasswordKey(request) { (response: LoginByUserPasswordKeyOutput?, error: NSError?) in
            self.title = "Raul"
            print("hola")
            print(response!.xmlResponseString)
            
        }
        return true;
    }
    
    func encryptPassword(password: String) -> String {
        let bytesFromPassword = [UInt8](password.utf8);
        var encryptedPassword = bytesFromPassword.sha512().toBase64()!;
        encryptedPassword = String(encryptedPassword.characters.map {$0 == "+" ? "-" : $0})
        encryptedPassword = String(encryptedPassword.characters.map {$0 == "/" ? "_" : $0})
        encryptedPassword = String(encryptedPassword.characters.map {$0 == "=" ? " " : $0})
        return encryptedPassword;
        
    }


}

