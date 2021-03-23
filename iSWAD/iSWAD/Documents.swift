//
//  Documents.swift
//  iSWAD
//
//  Created by Adrián Lara Roldán on 07/08/18.
//  Copyright © 2018 Adrián Lara Roldán. All rights reserved.
//  Modified by Bate Ye on 23/03/2021

import Foundation
import UIKit
import SWXMLHash
import WebKit

/**
 class that controls the view and navigation through the directory structure provided by swad
*/
class CollectionViewCell: UICollectionViewCell{
    @IBOutlet var icon: UILabel!
    @IBOutlet var label:UILabel!
    var code: String?
    var type: String?
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
            }
        }
    }
}

class DocumentsViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, WKNavigationDelegate{
    @IBOutlet var documens: UICollectionView!
    @IBOutlet var rootButton: UIButton!
    @IBOutlet var backButton: UIButton!
    var node: Folder?
    var actualNode:Folder?
    var ant = Array<Folder>()
    var c = CollectionViewCell()
    var detailItem: AnyObject?
    var marks: Bool?
    var url : URL?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (actualNode != nil){
            let folder = actualNode
            var nFolder = 0
            var nFiles = 0
            
            if folder?.childs != nil{
                nFolder = (folder?.childs!.count)!
            }
            if folder?.documents != nil{
                nFiles = (folder?.documents?.count)!
            }
            
            return nFiles+nFolder
        }else{
            let files = ant.last as! Folder
            return (files.documents!.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var object = [Any]()
        let cell = documens.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.icon.font = UIFont.fontAwesome(ofSize: 22)
        
        if self.actualNode?.childs != nil{
            for nodo in (self.actualNode?.childs)!{
                object.append(nodo)
            }
        }
        
        if self.actualNode?.documents != nil{
            for nodo in (self.actualNode?.documents)!{
                object.append(nodo)
            }
        }
        /// if it is a directory or a file ....
        if (object[indexPath.row] is Folder){
            let nodo = object[indexPath.row] as! Folder
            cell.icon.text = String.fontAwesomeIcon(code: "fa-folder-open")
            cell.label.text = nodo.name
            cell.type = "folder"
        }else{
            let nodo = object[indexPath.row] as! File
            cell.icon.text = String.fontAwesomeIcon(code: "fa-file-text-o")
            cell.label.text = nodo.name
            cell.type = "file"
            cell.code = nodo.code
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var object = [Any]()
        if self.actualNode?.childs != nil{
            for nodo in (self.actualNode?.childs)!{
                object.append(nodo)
            }
        }
        
        if self.actualNode?.documents != nil{
            for nodo in (self.actualNode?.documents)!{
                object.append(nodo)
            }
        }
        
        let cell = documens.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        /// if it is a directory the children are listed, in case of being a file a browser is opened if possible to show it
        if (actualNode is Folder){
            if object[indexPath.row] is Folder{
                self.ant.append(self.actualNode!)
                self.actualNode = object[indexPath.row] as? Folder
                self.reloadInputViews()
                self.documens.reloadData()
            }else{
                let obj: File = object[indexPath.row] as! File
                let client = SyedAbsarClient()
                let defaults = UserDefaults.standard
                
                if !marks!{
                    let requestFile = GetFile()
                    requestFile.cpFileCode = Int(obj.code!)!
                    requestFile.cpWsKey = defaults.string(forKey: Constants.wsKey)
                    client.opGetFile(requestFile){ (error: NSError?, response: XMLIndexer?) in
                        if error == nil {
                            let urlResponse = response!["getFileOutput"]["URL"].element?.text
                            _ = response!["getFileOutput"]["fileName"].element?.text
                            
                            if let url1 = URL(string: urlResponse!) {
                                if #available(iOS 11.0, *) {
                                    self.url = url1
                                } else {
                                    self.url = nil
                                    UIApplication.shared.openURL(url1)
                                }
                            }
                        }
                        
                    }
                }
                if let auxUrl = url{
                    let alert = showLoading()
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                        alert.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "showPdf", sender: self)
                    })
                }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? PDFViewController{
            destino.url = self.url
        }
    }
    override func loadView() {
        super.loadView()
        
        self.rootButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
        self.rootButton.setTitle(String.fontAwesomeIcon(name: .home), for: .normal)
        self.rootButton.setTitleColor(UIColor.black, for: UIControlState())
        self.rootButton.setTitleColor(UIColor.blue, for: .highlighted)
        
        self.backButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 25)
        self.backButton.setTitle(String.fontAwesomeIcon(name: .arrowUp), for: .normal)
        self.backButton.setTitleColor(UIColor.black, for: UIControlState())
        self.backButton.setTitleColor(UIColor.blue, for: .highlighted)
        
        if let detail = self.detailItem as? CoursesDetailViewController.Option {
            self.title = detail.name
        }
    }
    
    @IBAction func onTouchBack(_ sender: Any) {
        if (!self.ant.isEmpty){
            self.actualNode = self.ant.removeLast()
            self.reloadInputViews()
            self.documens.reloadData()
        }
    }
    
    @IBAction func onTouchRoot(_ sender: Any) {
        self.actualNode = self.node
        self.ant.removeAll()
        self.reloadInputViews()
        self.documens.reloadData()
    }
    
}
