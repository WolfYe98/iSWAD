//
//  MatchesViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 26/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController {

    var matches : [Match] = []
    var courseCode : Int?
    var gameCode : Int?
    
    @IBOutlet weak var tablaPartidas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tablaPartidas.register(UINib(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: "IconCell")
        self.tablaPartidas.dataSource = self
        self.tablaPartidas.tableFooterView = UIView()
    }
    
}


extension MatchesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaPartidas.dequeueReusableCell(withIdentifier: "IconCell") as! IconTableViewCell
        cell.title.text = matches[indexPath.row].title!
        
        cell.notaMaxima.text = ""
        
        let startTime = unixTimeToString(unixTimeStamp: matches[indexPath.row].startTime!)
        let endTime = unixTimeToString(unixTimeStamp: matches[indexPath.row].endTime!)
        cell.time.text = "\(startTime) - \(endTime)"
        
        cell.icon.font = UIFont.fontAwesome(ofSize: 28)
        cell.icon.text = String.fontAwesomeIcon(name: .checkSquareO)
        
        return cell
    }
    
    
}


