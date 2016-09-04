//
//  Utils.swift
//  iSWAD
//
//  Created by Raul Alvarez on 22/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation
import SWXMLHash
import CryptoSwift



func encryptPassword(password: String) -> String {
    let bytesFromPassword = [UInt8](password.utf8);
    var encryptedPassword = bytesFromPassword.sha512().toBase64()!;
    encryptedPassword = String(encryptedPassword.characters.map {$0 == "+" ? "-" : $0})
    encryptedPassword = String(encryptedPassword.characters.map {$0 == "/" ? "_" : $0})
    encryptedPassword = String(encryptedPassword.characters.map {$0 == "=" ? " " : $0})
    return encryptedPassword;
    
}


func toString(xml: XMLIndexer, id: String) -> String {
	print("To String")
	print(xml[id].element?.text)
	return (xml[id].element?.text)!
}

extension String {
	
	var html2AttributedString: NSAttributedString? {
		guard
			let data = dataUsingEncoding(NSUTF8StringEncoding)
			else { return nil }
		do {
			return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
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
		let barButtonItem = self.displayModeButtonItem()
		UIApplication.sharedApplication().sendAction(barButtonItem.action, to: barButtonItem.target, from: nil, forEvent: nil)
	}
}

func setServerURL(){
	let defaults = NSUserDefaults.standardUserDefaults()
	//defaults.setObject("https://swad.ugr.es/", forKey: Constants.serverURLKey)
	defaults.setObject("https://openswad.org/", forKey: Constants.serverURLKey)
}
func getServerURL() -> String {
	
	let defaults = NSUserDefaults.standardUserDefaults()
	return defaults.stringForKey(Constants.serverURLKey)!
}



func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
	
	
	let scale = CGFloat(max(size.width/image.size.width,
		size.height/image.size.height))
	let width:CGFloat  = image.size.width * scale
	let height:CGFloat = image.size.height * scale;
	
	let rr:CGRect = CGRectMake( 0, 0, width, height);
	
	UIGraphicsBeginImageContextWithOptions(size, false, 0);
	image.drawInRect(rr)
	let newImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext();
	return newImage
}