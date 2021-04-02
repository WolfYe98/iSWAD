//
//  CheckBox.swift
//  iSWAD
//
//  Created by Bate Ye on 30/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit

protocol CheckBoxDelegate:AnyObject{
    func addCode(_ code:Int)
    func removeCode(_ code: Int)
}
class CheckBox: UIButton {
    
    var code:Int?

    weak var delegate : CheckBoxDelegate?
    
    // Images
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "unchecked")! as UIImage
        
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
                delegate?.addCode(self.code!)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
                delegate?.removeCode(self.code!)
            }
        }
    }
            
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
