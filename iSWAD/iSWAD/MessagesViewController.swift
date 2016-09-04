//
//  MessagesViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 27/07/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash

class MessagesViewController: UIViewController{
	
	@IBOutlet var to: UITextField!
	
	@IBOutlet var carbonCopy: UITextField!
	
	@IBOutlet var subject: UITextField!
	
	@IBOutlet var body: UITextView!
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	var messageCode: String = "0"
	
	var contentFromNotification: AnyObject?{
		didSet(contentFromNotification) {
		}
	}

	
	@IBAction func onTouchSend(sender: AnyObject) {
		sendMessage()
		let alertController = UIAlertController(title: "iSWAD", message:"Mensaje enviado correctamente!", preferredStyle: UIAlertControllerStyle.Alert)
		alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: {(alert: UIAlertAction!) in
			self.navigationController?.popViewControllerAnimated(true)
		}))
		self.presentViewController(alertController, animated: true, completion: {		})
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
		body.layer.borderWidth = 0.5
		body.layer.borderColor = borderColor.CGColor
		body.layer.cornerRadius = 5.0
		if contentFromNotification != nil {
			showNotificationContent()
		}
	}
	
	func showNotificationContent() -> Void {
		
		var content = notification()
		content = contentFromNotification as! notification
		to.text = content.from
		to.enabled = false
		subject.text = "Re: "+content.summary
		body.text = "\n ---- Mensaje original ---- \n"+content.content.html2String
		messageCode = content.eventCode
	}
	
	func sendMessage() -> Void {
		
		print("Sending message")
		let clientMessage = SyedAbsarClient()
		let requestMessage = SendMessage()
		requestMessage.cpBody = body.text
		requestMessage.cpSubject = subject.text
		requestMessage.cpMessageCode = messageCode
		requestMessage.cpWsKey = defaults.stringForKey(Constants.wsKey)
		requestMessage.cpTo = "" +  carbonCopy.text! 
		clientMessage.opSendMessage(requestMessage){ (error: NSError?, response: XMLIndexer?) in
			print(response)
			let numUsers = response!["sendMessageOutput"]["numUsers"].element?.text
			if numUsers != "0" {
			}
		}
	}
}