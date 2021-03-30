//
//  UserTableViewCell.swift
//  iSWAD
//
//  Created by Bate Ye on 30/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit


class UserTableViewCell: UITableViewCell {
    var userSelected = false
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var checkBox: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.name.numberOfLines = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checked(_ sender: Any) {
        self.userSelected = !self.userSelected
        self.checkBox.isChecked = self.userSelected
    }
    
}
