//
//  InfoCourse.swift
//  iSWAD
//
//  Created by Raul Alvarez on 26/08/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController{
	@IBOutlet var informationText: UITextView!
	var info:String = ""
	
	override func viewWillAppear(animated: Bool) {
		let attrStr = try! NSAttributedString(
			data: info.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
			options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
			documentAttributes: nil)
		informationText.attributedText = attrStr
		informationText.font = informationText.font!.fontWithSize(22)
	}
}