//
//  InformationAlertViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 9/4/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit

class InformationAlertViewController: UIViewController {
    
    var imagen : UIImage!
    var error : Bool!
    var url:URL?
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tickView: UILabel!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageBotConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagen = UIImage(named: "error")
        self.backView.layer.cornerRadius = 20
        if error{
            self.tickView.removeFromSuperview()
            imageTopConstraint.constant = 10
            imageLeftConstraint.constant = 10
            imageRightConstraint.constant = 10
            imageBotConstraint.constant = 10
            self.backView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        else{
            imagen = UIImage(named: "nouserswad")
            if url != nil{
                if let datos = try? Data(contentsOf: url!){
                    if let im = UIImage(data: datos){
                        imagen = im
                    }
                }
            }
            self.tickView.font = UIFont.fontAwesome(ofSize: 30)
            self.tickView.text = String.fontAwesomeIcon(name: .check)
            self.backView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        }
        self.imageView.image = imagen
    }

}
