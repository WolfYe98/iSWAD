//
//  PDFViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 23/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var miview: UIView!
    @IBOutlet weak var milabel: UILabel!
    var url: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        //Debes actualizar el sistema a iOS 11 o superior para poder visualizar los PDFs.
        // Do any additional setup after loading the view.
        milabel.isHidden = true
        miview.backgroundColor = .black
        if #available(iOS 11.0, *) {
            let pdfview = PDFView()
            pdfview.backgroundColor = .black
            pdfview.translatesAutoresizingMaskIntoConstraints = false
            miview.addSubview(pdfview)
            pdfview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            pdfview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            pdfview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            pdfview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            if url != nil{
                if let documento = PDFDocument(url:url!){
                    pdfview.document = documento
                }
            }
            
        } else {
            milabel.isHidden = false
            milabel.numberOfLines = 20
            milabel.textAlignment = .center
            
            milabel.text = " Debes actualizar el sistema a iOS 11 o superior para poder visualizar los PDFs. "
        
        }
    }
}
