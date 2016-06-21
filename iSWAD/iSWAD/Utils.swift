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