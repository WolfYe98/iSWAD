//
//  Utils.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//


import Foundation
import SWXMLHash
import CryptoSwift

func encryptPassword(_ password: String) -> String {
    let bytesFromPassword = [UInt8](password.utf8);
    var encryptedPassword = bytesFromPassword.sha512().toBase64()!;
    encryptedPassword = String(encryptedPassword.map {$0 == "+" ? "-" : $0})
    encryptedPassword = String(encryptedPassword.map {$0 == "/" ? "_" : $0})
    encryptedPassword = String(encryptedPassword.map {$0 == "=" ? " " : $0})
    return encryptedPassword;
    
}


func toString(_ xml: XMLIndexer, id: String) -> String {
    return (xml[id].element?.text)!
}

extension String {
    var html2AttributedString: NSAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = self.displayModeButtonItem
        UIApplication.shared.sendAction(barButtonItem.action!, to: barButtonItem.target, from: nil, for: nil)
    }
}

func setServerURL(){
    let defaults = UserDefaults.standard
    //defaults.setObject("https://swad.ugr.es/", forKey: Constants.serverURLKey)
    defaults.set("https://openswad.org/", forKey: Constants.serverURLKey)
}

func getServerURL() -> String {
    
    let defaults = UserDefaults.standard
    return defaults.string(forKey: Constants.serverURLKey)!
}

func resizeImage(_ image:UIImage, toTheSize size:CGSize)->UIImage{
    let scale = CGFloat(max(size.width/image.size.width,
                            size.height/image.size.height))
    let width:CGFloat  = image.size.width * scale
    let height:CGFloat = image.size.height * scale;
    
    let rr:CGRect = CGRect( x: 0, y: 0, width: width, height: height);
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    image.draw(in: rr)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    return newImage!
}

