//
//  GamesViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 24/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit


class GamesViewController: UIViewController {
    var games : [Game] = []
    var refresh = UIRefreshControl()
    var courseCode : Int?
    
    
    @IBOutlet weak var tablaJuegos: UITableView!
    @IBOutlet weak var textoInformativo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        textoInformativo.numberOfLines = 10
        textoInformativo.text = "Desliza hacia abajo\npara traer los juegos"
        refresh.attributedTitle = NSAttributedString(string: "Cargando")
        refresh.addTarget(self, action: #selector(self.getData(_:)), for: .valueChanged)
        self.tablaJuegos.addSubview(refresh)
        self.tablaJuegos.register(UINib(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: "IconCell")
        self.tablaJuegos.dataSource = self
    }
    
    // Crea una petición SOAP al servidor, en caso de que no se devuelva ningún error, actualiza la tabla con los juegos, en caso contrario, muestra una alerta.
    // This method create a SOAP Request to the SWAD Server and if it doesn't return any error, updates the tableView with all games returned by SWAD Server and in the other case, it show an alert to the user.
    @objc func getData(_ sender:AnyObject){
        let defaults = UserDefaults.standard
        let request = GetGames()
        let client = SyedAbsarClient()
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpCourseCode = self.courseCode!
        client.opGetGames(request){ (error,response) in
            if error == nil{
                let gamesArray = response!["getGamesOutput"]["gamesArray"].children
                let game = Game()
                for item in gamesArray{
                    game.gameCode = Int((item["gameCode"].element?.text)!)
                    game.userSurname1 = (item["userSurname1"].element?.text)!
                    game.userSurname2 = (item["userSurname2"].element?.text)!
                    game.userFirstName = (item["userFirstname"].element?.text)!
                    game.userPhoto = (item["userPhoto"].element?.text)!
                    game.startTime = Int32((item["startTime"].element?.text)!)
                    game.endTime = Int32((item["endTime"].element?.text)!)
                    game.title = (item["title"].element?.text)!
                    game.text = (item["text"].element?.text)!
                    game.numQuestions = Int((item["numQuestions"].element?.text)!)
                    game.maxGrade = Float((item["maxGrade"].element?.text)!)
                    
                    //add to games array
                    self.games.append(game)
                }
                DispatchQueue.main.async {
                    self.textoInformativo.removeFromSuperview()
                }
            }
            else{
                DispatchQueue.main.sync {
                    showAlert(self, message: error!.localizedDescription, 1){boleano in}
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.tablaJuegos.reloadData()
            self.refresh.endRefreshing()
        }
    }
}

extension GamesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaJuegos.dequeueReusableCell(withIdentifier: "IconCell") as! IconTableViewCell
        if games.count > 0{
            cell.title.text = games[indexPath.row].title
            cell.icon.font = UIFont.fontAwesome(ofSize: 28)
            cell.icon.text = String.fontAwesomeIcon(name: .checkSquareO)
            cell.time.text = "\(games[indexPath.row].startTime) - \(games[indexPath.row].endTime)"
        }
        return cell
    }
    
    
}
