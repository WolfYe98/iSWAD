//
//  Tree.swift
//  iSWAD
//
//  Created by Adrián Lara Roldán on 07/08/18.
//  Copyright © 2018 Adrián Lara Roldán. All rights reserved.
//

import Foundation
import UIKit
import SWXMLHash

/**
 struct modeling a directory
 */
struct File : XMLIndexerDeserializable{
    var name: String?
    var code: String?
    
    static func deserialize(_ node: XMLIndexer) throws -> File {
        return try File(
            name: node.value(ofAttribute: "name"),
            code: node["code"].value()
        )
    }
}

/**
 struct modeling a file
 */
struct Folder : XMLIndexerDeserializable{
    var name : String?
    var childs : [Folder]?
    var documents :[File]?
    
    static func deserialize(_ node: XMLIndexer) throws -> Folder {
        return try Folder(
            name: node.value(ofAttribute: "name"),
            childs: node["dir"].value(),
            documents: try! node["file"].value()
        )
    }
}

/**
 class that models the directory tree
 */
class Root{
    var root = Folder()
    var ant: Folder
    
    init(xmlTree : String) {
        let xml = SWXMLHash.config { conf in
            conf.shouldProcessNamespaces = true
            }.parse(xmlTree)
        self.root.name = "root"
        self.root.childs = try! xml["tree"]["dir"].value()
        self.root.documents = try! xml["tree"]["file"].value()
        ant = self.root
    }
}
