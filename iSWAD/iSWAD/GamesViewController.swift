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
    var gameCode :Int?
    var matches : [Match] = []
    var dic_game : [String:Bool] = [String:Bool]()
    @IBOutlet weak var tablaJuegos: UITableView!
    
    var textoInformativo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Juegos"
        self.tablaJuegos.tableFooterView = UIView()
        
        // Put a first label in the middle of the table view
        self.textoInformativo = createInfoLabel(self.tablaJuegos, message: "Desliza hacia abajo para traer los juegos", textSize: 23)
        self.tablaJuegos.addSubview(self.textoInformativo)
        
        refresh.attributedTitle = NSAttributedString(string: "Cargando")
        refresh.addTarget(self, action: #selector(self.getData(_:)), for: .valueChanged)
        self.tablaJuegos.addSubview(refresh)

        self.tablaJuegos.register(UINib(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: "IconCell")
        self.tablaJuegos.dataSource = self
        self.tablaJuegos.delegate = self
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
                if Int((response!["getGamesOutput"]["numGames"].element?.text)!) == 0{
                    DispatchQueue.main.sync {
                        showAlert(self, message: "No hay juegos disponibles para este curso", 1, handler: {booleano in
                            self.refresh.endRefreshing()
                        })
                    }
                    return
                }
                let gamesArray = response!["getGamesOutput"]["gamesArray"].children
                
                for item in gamesArray{
                    let game = Game()
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
                    let key = String(game.gameCode!) + game.title! + game.text!
                    if self.dic_game.keys.contains(key) == false{
                        self.games.append(game)
                        self.dic_game[key] = true
                    }
                    else{
                        for ga in self.games{
                            if String(ga.gameCode!)+ga.title!+ga.text! != key{continue}
                            ga.startTime = game.startTime
                            ga.endTime = game.endTime
                            ga.maxGrade = game.maxGrade
                            ga.numQuestions = game.numQuestions
                        }
                    }
                }
            }
            
            else{
                DispatchQueue.main.asyncAfter(deadline:.now()) {
                    showAlert(self, message: error!.localizedDescription, 1){boleano in}
                }
                return
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.tablaJuegos.reloadData()
            self.refresh.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = (segue.destination as! MatchesViewController)
        destino.courseCode = self.courseCode
        destino.gameCode = self.gameCode
        destino.matches = self.matches
    }
}

extension GamesViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablaJuegos.dequeueReusableCell(withIdentifier: "IconCell") as! IconTableViewCell
        if games.count > 0{
            cell.title.text = games[indexPath.row].title
            
            cell.icon.font = UIFont.fontAwesome(ofSize: 28)
            cell.icon.text = String.fontAwesomeIcon(name: .gamepad)
            
            cell.notaMaxima.text = "Nota máxima: "+String(games[indexPath.row].maxGrade!)
            
            let startDate = unixTimeToString(unixTimeStamp: games[indexPath.row].startTime!)
            let endDate = unixTimeToString(unixTimeStamp: games[indexPath.row].endTime!)
            cell.time.text = "\(startDate) - \(endDate)"
            self.textoInformativo.removeFromSuperview()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        let client = SyedAbsarClient()
        let request = GetMatches()
        let alert = showLoading(message: "Cargando Partidas...")
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpCourseCode = self.courseCode
        request.cpGameCode = self.games[indexPath.row].gameCode!
        self.gameCode = self.games[indexPath.row].gameCode!
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.present(alert, animated: true, completion: nil)
        }
        
        client.opGetMatches(request){ (error,response) in
            if error != nil{
                DispatchQueue.main.sync {
                    alert.dismiss(animated: true, completion: nil)
                    showAlert(self, message: error!.localizedDescription, 1, handler: {boleano in})
                }
                return
            }
            else{
                self.matches = []
                let numMatches = Int((response!["getMatchesOutput"]["numMatches"].element?.text)!)
                if numMatches == 0{
                    DispatchQueue.main.sync {showAlert(self, message: "No hay ningún partido para el juego seleccionado!", 1, handler: {boleano in})}
                    return
                }
                let matchArray = response!["getMatchesOutput"]["matchesArray"].children
                for item in matchArray{
                    let match = Match()
                    match.matchCode = Int((item["matchCode"].element?.text)!)
                    match.startTime = Int32((item["startTime"].element?.text)!)
                    match.endTime = Int32((item["endTime"].element?.text)!)
                    match.title = (item["title"].element?.text)!
                    match.questionIndex = Int((item["questionIndex"].element?.text)!)

                    self.matches.append(match)
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    alert.dismiss(animated: true, completion: nil)
                    self.performSegue(withIdentifier: "toMatch", sender: self)
                }
            }
        }
    }
    
}
