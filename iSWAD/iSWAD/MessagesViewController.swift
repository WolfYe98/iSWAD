//
//  MessagesViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//

import Foundation
import UIKit
import SWXMLHash

class MessagesViewController: UIViewController{
    @IBOutlet var to: UITextField!
    @IBOutlet var send: UIButton!
    @IBOutlet var carbonCopy: UITextField!
    @IBOutlet var subject: UITextField!
    @IBOutlet var body: UITextView!
    
    let defaults = UserDefaults.standard
    var messageCode: String = "0"
    var contentFromNotification: AnyObject?{
        didSet(contentFromNotification) {
        }
    }
    
    @IBAction func onTouchSend(_ sender: AnyObject) {
        sendMessage()
        let alertController = UIAlertController(title: "iSWAD", message:"Mensaje enviado correctamente!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: {(alert: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: {        })
    }
    
    override func loadView() {
        super.loadView()
        
        self.send.titleLabel?.font = UIFont.fontAwesome(ofSize:25)
        self.send.setTitle(String.fontAwesomeIcon(name: .paperPlane), for: .normal)
        self.send.setTitleColor(UIColor.black, for: UIControlState())
        self.send.setTitleColor(UIColor.blue, for: .highlighted)
        self.send.titleLabel?.font = UIFont.fontAwesome(ofSize:25)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        body.layer.borderWidth = 0.5
        body.layer.borderColor = borderColor.cgColor
        body.layer.cornerRadius = 5.0
        if contentFromNotification != nil {
            showNotificationContent()
        }
    }
    
    func showNotificationContent() -> Void {
        var content = notification()
        content = contentFromNotification as! notification
        to.text = content.from
        to.isEnabled = false
        subject.text = "Re: "+content.summary
        body.text = "\n ---- Mensaje original ---- \n"+content.content.html2String
        messageCode = content.eventCode
    }
    
    func sendMessage() -> Void {
        let clientMessage = SyedAbsarClient()
        let requestMessage = SendMessage()
        requestMessage.cpBody = "\(body.text) \n\nEnviado desde iSWAD"
        requestMessage.cpSubject = subject.text
        requestMessage.cpMessageCode = messageCode
        requestMessage.cpWsKey = defaults.string(forKey: Constants.wsKey)
        requestMessage.cpTo = to.text!

        if (carbonCopy.text != "") {
            requestMessage.cpTo = "\(requestMessage.cpTo ?? ""),\(carbonCopy.text!)"
        }
        
        clientMessage.opSendMessage(requestMessage){ (error: NSError?, response: XMLIndexer?) in
            let numUsers = response!["sendMessageOutput"]["numUsers"].element?.text
            if numUsers != "0" {
            }
        }
    }
}
