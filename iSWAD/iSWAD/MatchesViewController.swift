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
    var firstNumAnswers:Int?
    var firstQuestionIndex: Int?
    var firstAnswerIndex: Int?
    var firstStatusCode: Int?
    var matchCode:Int?
    @IBOutlet weak var tablaPartidas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Partidas"
        self.tablaPartidas.register(UINib(nibName: "IconTableViewCell", bundle: nil), forCellReuseIdentifier: "IconCell")
        self.tablaPartidas.dataSource = self
        self.tablaPartidas.tableFooterView = UIView()
        self.tablaPartidas.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! AnswersViewController
        destino.courseCode = self.courseCode
        destino.gameCode = self.gameCode
        destino.matchCode = self.matchCode
        destino.numAnswers = self.firstNumAnswers
        destino.questionIndex = self.firstQuestionIndex
        destino.answerIndex = self.firstAnswerIndex
        destino.statusCode = self.firstStatusCode
    }
}


extension MatchesViewController:UITableViewDataSource,UITableViewDelegate{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = SyedAbsarClient()
        let request = GetMatchStatus()
        let defaults = UserDefaults.standard
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpCourseCode = self.courseCode
        request.cpGameCode = self.gameCode
        request.cpMatchCode = self.matches[indexPath.row].matchCode!
        self.matchCode = self.matches[indexPath.row].matchCode!
        let alert = showLoading(message: "Cargando Preguntas...")
        
        DispatchQueue.main.asyncAfter(deadline:.now()) {self.present(alert, animated: true, completion: nil)}
        
        client.opGetMatchStatus(request){error,response in
            if error != nil{
                DispatchQueue.main.asyncAfter(deadline:.now()) {
                    alert.dismiss(animated: true, completion: nil)
                    showAlert(self, message: error!.localizedDescription, 1, handler: {boleano in})
                    return
                }
            }
            DispatchQueue.main.asyncAfter(deadline:.now()+1) {
                alert.dismiss(animated: true, completion: nil)

                self.matchCode = self.matches[indexPath.row].matchCode!
                self.firstQuestionIndex = Int((response!["getMatchStatusOutput"]["questionIndex"].element?.text)!)
                self.firstNumAnswers = Int((response!["getMatchStatusOutput"]["numAnswers"].element?.text)!)
                self.firstAnswerIndex = Int((response!["getMatchStatusOutput"]["answerIndex"].element?.text)!)
                self.firstStatusCode = Int((response!["getMatchStatusOutput"]["matchCode"].element?.text)!)
                
                
                self.performSegue(withIdentifier: "toAnswer", sender: self)
            }
        }
    }
}


