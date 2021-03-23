//
//  Utils.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//  Modified by Bate Ye on 23/03/2021


import Foundation
import SWXMLHash
import CryptoSwift
import UIKit


//Show an alert to the user.
public func showAlert(_ view: UIViewController,message: String, _ options:Int, handler: @escaping (_ accepted:Bool)->Void){
    let alert = UIAlertController(title: "iSWAD", message: message, preferredStyle: .alert)
    if options == 2{
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ _ in
            handler(true)
        } ))
    }
    if options >= 0{
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:{ _ in
            handler(false)
        } ))
    }
    view.present(alert, animated: true, completion: nil)
}

//Return an UIAlertController with an indicator in to it.
public func showLoading() -> UIAlertController{
    let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
    let indicador = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    indicador.hidesWhenStopped = true
    indicador.startAnimating()
    alert.view.addSubview(indicador)
    return alert
}

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

