//
//  QrViewController.swift
//  iSWAD
//
//  Created by Adrián Lara Roldán on 7/8/18.
//  Copyright © 2018 Adrián Lara Roldán. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash

/**
 class to control the view of the QR code with the username
 */
class QrViewController: UIViewController{
    @IBOutlet var qrImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let image = generateQRCode(from:defaults.string(forKey: Constants.userIDKey)!)
        
        qrImage.image = image

    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 20, y: 20)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
