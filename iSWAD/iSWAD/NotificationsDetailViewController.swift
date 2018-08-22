//
//  NotificationsDetailViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//


import UIKit
import SWXMLHash

class NotificationsDetailViewController: UIViewController {
    @IBOutlet var notificationsContent: UITextView!
    @IBOutlet var personImage: UIImageView!
    @IBOutlet var from: UILabel!
    @IBOutlet var subject: UILabel!
    @IBOutlet var summary: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var toolbar: UIToolbar!
    
    var detailItem: AnyObject? {
        didSet(detailItem) {
            self.configureView()
        }
    }
    
    func configureView() {
        if let detail = self.detailItem {
            if self.notificationsContent != nil {
                var not = notification()
                not = detail as! notification
                self.notificationsContent.text = not.content.html2String
                self.notificationsContent.font = UIFont(name: "Helvetica", size: 20)
                self.from.text = not.from
                self.subject.text = not.location
                self.date.text = not.date
                self.summary.text = not.summary
                let url = URL(string: not.userPhoto)
                
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    let data = try? Data(contentsOf: url!)
                    DispatchQueue.main.async(execute: {
                        self.personImage.image = UIImage(data: data!)
                    });
                }
                
                self.title = not.type
                
                if not.type == "Mensaje" {
                    let answerButton = UIBarButtonItem(title: "Responder", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NotificationsDetailViewController.onTouchAnswer(_:)))
                    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
                    toolbar.items = [flexibleSpace, flexibleSpace, answerButton]
                }
                
                let client = SyedAbsarClient()
                let defaults = UserDefaults.standard
                let requestReadNotification = MarkNotificationsAsRead()
                requestReadNotification.cpWsKey = defaults.string(forKey: Constants.wsKey)
                requestReadNotification.cpNotifications = not.id
                client.opMarkNotificationsAsRead(requestReadNotification){(error, response2: XMLIndexer?) in
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let destinationVC = segue.destination as! MessagesViewController
        destinationVC.contentFromNotification = detailItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTouchAnswer(_ sender: AnyObject){
        performSegue(withIdentifier: "showAnswer", sender: nil)
    }
}
