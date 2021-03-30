//
//  UserListViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 30/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    var courseCode : Int?
    var dic_events = [String:Bool]()
    var refresh:UIRefreshControl = UIRefreshControl()
    var events : [AttendanceEvent] = [AttendanceEvent]()
    var selectedEvent : Int?
    
    var textInformation: UILabel!
    @IBOutlet weak var tablaEventos: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Eventos"
        self.textInformation = createInfoLabel(self.tablaEventos, message: "Desliza hacia abajo para traer los eventos", textSize: 23)
        self.tablaEventos.addSubview(self.textInformation)
        
        
        self.tablaEventos.register(UINib(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: "IconCell")
        self.tablaEventos.tableFooterView = UIView()

        self.tablaEventos.dataSource = self
        self.tablaEventos.delegate = self
        
        refresh.attributedTitle = NSAttributedString(string: "Cargando")
        refresh.addTarget(self, action: #selector(self.getData(_:)), for: .valueChanged)
        self.tablaEventos.addSubview(self.refresh)
    }
    
    
    //Selectors:
    @objc func getData(_ sender : AnyObject){
        let defaults = UserDefaults.standard
        let client = SyedAbsarClient()
        let request = GetAttendanceEvents()
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpCourseCode = self.courseCode!
        
        client.opGetAttendanceEvents(request){error,response in
            if error != nil{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    showAlert(self, message: error!.localizedDescription, 1, handler: {boleano in
                        self.refresh.endRefreshing()
                    })
                    
                }
                return
            }
            let eventsArray = response!["getAttendanceEventsOutput"]["eventsArray"].children
            
            for item in eventsArray{
                
                let key = (item["attendanceEventCode"].element?.text)! + (item["title"].element?.text)!
                if self.dic_events.keys.contains(key){
                    for ev in self.events{
                        if String(ev.cpAttendanceEventCode!) + ev.cpTitle! != key{ continue }
                        ev.cpHidden = Int((item["hidden"].element?.text)!)
                    }
                    continue
                }
                self.dic_events[key] = true
                
                let event = AttendanceEvent()
                event.cpAttendanceEventCode = Int( (item["attendanceEventCode"].element?.text)! )
                event.cpHidden = Int( (item["hidden"].element?.text)! )
                event.cpUserSurname1 = item["userSurname1"].element?.text
                event.cpUserSurname2 = item["userSurname2"].element?.text
                event.cpUserFirstname = item["userFirstname"].element?.text
                event.cpUserPhoto = item["userPhoto"].element?.text
                event.cpStartTime = Int32( (item["startTime"].element?.text)! )
                event.cpEndTime = Int32( (item["endTime"].element?.text)! )
                event.cpCommentsTeachersVisible = Int( (item["commentsTeachersVisible"].element?.text)! )
                event.cpTitle = item["title"].element?.text
                event.cpText = item["text"].element?.text
                
                self.events.append(event)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.refresh.endRefreshing()
            self.tablaEventos.reloadData()
        }
    }
}

extension UserListViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaEventos.dequeueReusableCell(withIdentifier: "IconCell") as! IconTableViewCell
        if events.count > 0{
            cell.title.text = events[indexPath.row].cpTitle
            
            cell.icon.font = UIFont.fontAwesome(ofSize: 28)
            cell.icon.text = String.fontAwesomeIcon(name: .checkSquareO)
            
            
            let startDate = unixTimeToString(unixTimeStamp: events[indexPath.row].cpStartTime!)
            let endDate = unixTimeToString(unixTimeStamp: events[indexPath.row].cpEndTime!)
            cell.time.text = "\(startDate) - \(endDate)"
            self.textInformation.removeFromSuperview()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedEvent = events[indexPath.row].cpAttendanceEventCode
        self.performSegue(withIdentifier: "toEvent", sender: self)
    }
}
