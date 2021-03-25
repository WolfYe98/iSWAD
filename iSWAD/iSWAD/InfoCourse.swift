//
//  InfoCourse.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//

import Foundation
import WebKit

class InfoViewController:UIViewController, WKNavigationDelegate{
    @IBOutlet var webView: WKWebView!
    var info:String?
    var URLL = false
    var url = ""
    var enlaces:Bool = false
    
    override func loadView() {
        if !self.enlaces{
            let input = info
            /// if the content is a single url, in that case the content is in the link
            if((input?.count)! >= 4){
                let index: String.Index = input!.index(input!.startIndex, offsetBy: 4)
                let result: String = String(input![..<index])
            
                if(result == "http"){
                    let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                    let matches = detector.matches(in: input!, options: [], range: NSRange(location: 0, length: (input?.utf16.count)!))
                    if matches.count > 0{
                        URLL = true
                    }
                
                    for match in matches {
                        guard let range = Range(match.range, in: input!) else { continue }
                        url = String(input![range])
                    }
                }
            }
        }
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    @IBAction func unwind(_ seg: UIStoryboardSegue) {
    }
    override func viewDidLoad() {
        if (self.info?.isEmpty)! {
            /// default text if there is no information
            self.info = "<!DOCTYPE html><html lang=\"es\"><head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=windows-1252\" /><title>Informaci&oacute;n</title></head><body> <h1>No existe información</h1></html></body>"
        }
        
        super.viewDidLoad()
        
        /// if it is a url we load the page in the webview
        if URLL {
            let urll = URL(string: self.url)!
            webView.load(URLRequest(url: urll))
        }else{
            webView.loadHTMLString(self.info!, baseURL: nil)
        }
        /// otherwise the content is displayed
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
