//
//  IconTableViewCell.swift
//  iSWAD
//
//  Created by Bate Ye on 25/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit
// This class represent my custom cells, this type of cell have a title, a timeline and an icon.

class IconTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var notaMaxima: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
