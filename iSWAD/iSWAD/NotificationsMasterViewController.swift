//
//  NotificationsMasterViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//

import UIKit
import SWXMLHash
import FontAwesome_swift
import SQLite3

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

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
    var eventCode = String()
}

class cellNotification: UITableViewCell{
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var icono: UILabel!
}

class NotificationsMasterViewController: UITableViewController {
    @IBOutlet var subjectsButton: UIButton!
    @IBOutlet weak var newMessage: UIButton!
    @IBOutlet var reload: UIButton!
    
    fileprivate var collapseDetailViewController = true
    var notificationsList:[notification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notificaciones"
        self.tableView.dataSource = self;
        if notificationsList.isEmpty{
            getNotifications()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.subjectsButton.titleLabel?.font = UIFont.fontAwesome(ofSize:20)
        self.subjectsButton.setTitle(String.fontAwesomeIcon(name: .folderOpen), for: .normal)
        self.subjectsButton.setTitleColor(UIColor.black, for: UIControlState())
        self.subjectsButton.setTitleColor(UIColor.blue, for: .highlighted)
        
        self.newMessage.titleLabel?.font = UIFont.fontAwesome(ofSize:20)
        self.newMessage.setTitle(String.fontAwesomeIcon(name: .envelope), for: .normal)
        self.newMessage.setTitleColor(UIColor.black, for: UIControlState())
        self.newMessage.setTitleColor(UIColor.blue, for: .highlighted)
        
        self.reload.titleLabel?.font = UIFont.fontAwesome(ofSize:20)
        self.reload.setTitle(String.fontAwesomeIcon(name: .refresh), for: .normal)
        self.reload.setTitleColor(UIColor.black, for: UIControlState())
        self.reload.setTitleColor(UIColor.blue, for: .highlighted)
    }
    
    //MARK: Table View Data Source and Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsList.count
    }
    
    /*!
     Setup of the table view for the notifications
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNotifications", for: indexPath) as! cellNotification
        cell.type.text = notificationsList[indexPath.row].type
        cell.summary.text = notificationsList[indexPath.row].summary
        cell.subject.text = notificationsList[indexPath.row].location
        cell.date.text = notificationsList[indexPath.row].date
        cell.from.text = notificationsList[indexPath.row].from
        
        if notificationsList[indexPath.row].unread {
            cell.backgroundColor = UIColor.cyan
        }
        
        cell.icono.font = UIFont.fontAwesome(ofSize: 50)
        cell.icono.text = String.fontAwesomeIcon(code: notificationsList[indexPath.row].icono)
        
        return cell
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNotification" {
            self.splitViewController?.toggleMasterView()
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = notificationsList[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! NotificationsDetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    func getNotifications() -> Void {
        db = openDatabase()
        let time = CLong(NSDate().timeIntervalSince1970) - query(since: true)
        update()
        
        let client = SyedAbsarClient()
        let defaults = UserDefaults.standard
        
        let requestNotifications = GetNotifications()
        requestNotifications.cpWsKey = defaults.string(forKey: Constants.wsKey)
        requestNotifications.cpBeginTime = time
        
        client.opGetNotifications(requestNotifications){ (error, response: XMLIndexer?) in
            let notificationsArray = response!["getNotificationsOutput"]["notificationsArray"].children
            
            for item in notificationsArray{
                let noti = notification()
                noti.id = (item["notifCode"].element?.text)!
                noti.eventCode = (item["eventCode"].element?.text)!
                noti.summary = (item["summary"].element?.text)!
                noti.location = (item["location"].element?.text)!
                noti.userPhoto = (item["userPhoto"].element?.text)!
                
                switch (item["eventType"].element?.text)! {
                case Constants.notificationType.enrollmentStudent.rawValue:
                    noti.type = "Inscripción"
                    noti.content = "Has sido ingresado como estudiante en la asignatura "+(item["location"].element?.text)!
                    noti.icono = "fa-user-plus"
                case Constants.notificationType.enrollmentTeacher.rawValue:
                    noti.type = "Inscripción"
                    noti.content = "Has sido ingresado como profesor en la asignatura "+(item["location"].element?.text)!
                    noti.icono = "fa-graduation-cap"
                    noti.summary = "Profesor"
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
                
                if Int((item["status"].element?.text)!) < 4{
                    noti.unread = true
                } else {
                    noti.unread = false
                }
                
                let timeInterval = Double((item["eventTime"].element?.text)!)
                
                let date = Date(timeIntervalSince1970: timeInterval!)
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                let dateString = formatter.string(from: date)
                
                noti.date = dateString
                noti.from = (item["userFirstname"].element?.text)!+" "+(item["userSurname1"].element?.text)!
                
                self.notificationsList.append(noti)
            }
            
            // We have to send the reloadData to the UIThread otherwise won't be instant
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })
        }
        sleep(1)
    }
    
    func openDatabase() -> OpaquePointer? {
        //the database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("swad.sqlite")
        
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            return nil
        }
    }
    
    func insert(db:OpaquePointer,id:Int, name:String,value:Int) {
        var insertStatement: OpaquePointer? = nil
        let insertStatementString = "INSERT INTO swad (id,name,value) VALUES (?,?,?)"
        
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let id: Int32 = Int32(id)
            let name: NSString = name as NSString
            let value: Int32 = Int32(value)
            
            // 2
            sqlite3_bind_int(insertStatement, 1, id)
            // 3
            sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
            
            sqlite3_bind_int(insertStatement, 3, value)
            
            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func query(since:Bool) ->Int{
        var time = 0
        var queryStatementString = "SELECT value FROM swad WHERE name = 'time'"
        if since{
            queryStatementString = "SELECT value FROM swad WHERE name = 'periode'"
        }
        
        
        var queryStatement: OpaquePointer? = nil
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // 2
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // 3
                time = Int(sqlite3_column_int(queryStatement, 0))
                
                
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        // 6
        sqlite3_finalize(queryStatement)
        return time
    }
    
    func update() {
        let updateStatementString = "UPDATE swad SET value = \(Int32(CLong(NSDate().timeIntervalSince1970))) WHERE name = 'time'"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
    @IBAction func onTouchSubjects(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CoursesView") as! UISplitViewController
        vc.minimumPrimaryColumnWidth = 0
        vc.maximumPrimaryColumnWidth = 600
        vc.preferredPrimaryColumnWidthFraction = 0.6
        let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = vc
    }
    
    @IBAction func reload(_ sender: Any) {
        self.viewDidLoad()
        self.reloadInputViews()
        self.tableView.reloadData()
    }
}

