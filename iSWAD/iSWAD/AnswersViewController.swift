//
//  AnswersViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 27/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    var courseCode : Int?
    var gameCode : Int?
    var matchCode:Int?
    var questionIndex: Int?
    var answerIndex:Int?
    var numAnswers:Int?
    var statusCode:Int?
    var timer:Timer? = nil
    
    let abcDary : [String:UIColor] = ["A":.red,"B":.blue,"C":.systemYellow,"D":.systemGreen,"E":.systemPurple,"F":.cyan,"G":.orange,"H":.systemRed,"I":.systemBlue,"J":.yellow,"K":.purple,"L":.cyan,"M":.orange,"N":.red,"O":.blue,"P":.systemYellow,"Q":.systemGreen,"R":.systemPurple,"S":.cyan,"T":.orange,"U":.systemRed,"V":.systemBlue,"W":.yellow,"X":.green,"Y":.purple,"Z":.cyan]
    let abc = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var stackRespuestas: UIStackView!
    @IBOutlet weak var information: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Preguntas"
        self.information.numberOfLines = 20
        configureView()
        if #available(iOS 10.0, *) {
            //timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.reload), userInfo: nil, repeats: true)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){timer in
                self.reload()
            }
        } else {
            self.information.isHidden = false
            self.information.text = "Esta opción solamente es válida para dispositivos con iOS 10.0 o superior"
        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate()
    }
    
    //Function that configure the answer view with a message or with the buttons.
    func configureView(){
        if questionIndex != nil{
            self.titulo.text = "Pregunta " + String(self.questionIndex!)
        }
        if self.statusCode! > 0{
            if let numAns = self.numAnswers{
                self.information.isHidden = true
                for index in (0..<numAns){
                    let btn: UIButton = UIButton()
                    btn.backgroundColor = self.abcDary[self.abc[index % self.abc.count]]
                    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21)
                    btn.setTitle(self.abc[index % self.abc.count], for: .normal)
                    btn.addTarget(self, action: #selector(self.answerSelected(sender:)), for: .touchUpInside)
            
                    self.stackRespuestas.addArrangedSubview(btn)
                }
            }
        }
        else{
            self.titulo.text = "Espera!"
            self.information.isHidden = false
            self.information.text = "Aún no puedes resolver esta pregunta"
        }
    }
    
    // Action asociated to each answer button.
    @objc func answerSelected(sender:UIButton){
        let ansIndex = abc.index(of: (sender.titleLabel?.text)!)
        let client = SyedAbsarClient()
        let defaults = UserDefaults.standard
        let request = AnswerMatchQuestion()
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpCourseCode = self.courseCode!
        request.cpGameCode = self.gameCode!
        request.cpMatchCode = self.matchCode!
        request.cpQuestionIndex = self.questionIndex!
        request.answerIndex = ansIndex
        
        client.opAswerMatchQuestion(request){error,response in
            if error != nil{
                DispatchQueue.main.sync {
                    showAlert(self, message: error!.localizedDescription, 1, handler:{boleano in})
                }
            }
            let num = Int((response!["answerMatchQuestionOutput"]["matchCode"].element?.text)!)!
            if  num < 0 {
                showAlert(self, message: "Error vuelve a pulsar la respuesta", 1, handler: {boleano in})
            }
            else{
                DispatchQueue.main.sync {
                    for view in self.stackRespuestas.subviews{
                        if view == sender{continue}
                        view.layer.borderWidth = 0
                    }
                    sender.layer.borderWidth = 10
                    sender.layer.borderColor = UIColor.white.cgColor
                }
            }
            self.getStatus()
        }
    }
    
    @objc func reload(){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.getStatus()
            if self.information.isHidden == true && self.statusCode == 0{
                for view in self.stackRespuestas.subviews{
                    if view is UIButton{
                        view.removeFromSuperview()
                    }
                }
                self.information.isHidden = false
                self.information.text = "Aún no puedes contestar a esta pregunta"
            }
            else if self.information.isHidden == false && self.statusCode! > 0{
                    self.information.isHidden = true
                    self.configureView()
            }
        }
    }
    // This function make a SOAP request to SWAD server and receive the status of the match
    func getStatus(){
        let defaults = UserDefaults.standard
        let client = SyedAbsarClient()
        let request = GetMatchStatus()
    
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpCourseCode = self.courseCode
        request.cpGameCode = self.gameCode
        request.cpMatchCode = self.matchCode
        client.opGetMatchStatus(request){ error, response in
            if error != nil{
                DispatchQueue.main.sync {
                    if let _ = self.timer?.isValid{
                        self.timer?.invalidate()
                    }
                    showAlert(self, message: error!.localizedDescription, 1, handler: {boleano in
                        if let _ = self.timer{
                            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){timer in
                                self.reload()
                            }
                        }
                    })
                }
                return
            }
            self.statusCode = Int((response!["getMatchStatusOutput"]["matchCode"].element?.text)!)
            self.questionIndex = Int((response!["getMatchStatusOutput"]["questionIndex"].element?.text)!)
            self.numAnswers = Int((response!["getMatchStatusOutput"]["numAnswers"].element?.text)!)
            self.answerIndex = Int((response!["getMatchStatusOutput"]["answerIndex"].element?.text)!)
        }
    }
}
