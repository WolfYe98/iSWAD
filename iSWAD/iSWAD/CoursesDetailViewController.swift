//
//  CoursesDetailViewController.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//

import UIKit
import SWXMLHash

class cellOption: UITableViewCell{
    @IBOutlet var option: UILabel!
    @IBOutlet var icon: UILabel!
}

class CoursesDetailViewController: UITableViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet var subjectDetailTable: UITableView!
    
    let kHeaderSectionTag: Int = 6900;
    var expandedSectionHeaderNumber: Int = -1
    var courseInformation: String = ""
    var courseGuide: String = ""
    var courseLectures: String = ""
    var coursePracticals: String = ""
    var courseBibliography: String = ""
    var courseFAQ: String = ""
    var courseLinks: String = ""
    var courseAssessment: String = ""
    var courseCode: Int = 1
    var documents: String = ""
    var shared: String = ""
    var marks: String = ""
    var treeCode :Int = 0
    var iconSections:[String] = ["fa-list-ol","fa-check-square","fa-folder-open","fa-users"]
    var sectionTitles:[String] = ["Asignatura", "Evaluación", "Archivos","Usuarios"]
    
    /// Class for string the options for each subject
    class Option: Any{
        var name: String = ""
        var segue: String = ""
        var image: String = ""
        
        init (name: String, image: String, segue: String){
            self.name = name
            self.image = image
            self.segue = segue
        }
    }
    
    var optionsForSubject = [[Option]]()
    var detailItem: AnyObject? {
        didSet(detailItem) {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem as? CoursesMasterViewController.Course {
            self.title = detail.name
            self.courseCode = detail.code
            getCourseInfo(self.courseCode, infoType: "introduction")
            getCourseInfo(self.courseCode, infoType: "guide")
            getCourseInfo(self.courseCode, infoType: "lectures")
            getCourseInfo(self.courseCode, infoType: "practicals")
            getCourseInfo(self.courseCode, infoType: "bibliography")
            getCourseInfo(self.courseCode, infoType: "FAQ")
            getCourseInfo(self.courseCode, infoType: "links")
            getCourseInfo(self.courseCode, infoType: "assessment")
            getCourseDocument(self.courseCode, treeCode: 1)
            getCourseDocument(self.courseCode, treeCode: 2)
            getCourseDocument(self.courseCode, treeCode: 3)
        }
    }
    
    //MARK: Table View Data Source and Delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return optionsForSubject.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            return optionsForSubject[section].count
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSubject", for: indexPath) as! cellOption
        
        cell.option.text = optionsForSubject[indexPath.section][indexPath.row].name
        cell.icon.font = UIFont.fontAwesome(ofSize: 22)
        cell.icon.text = String.fontAwesomeIcon(code: optionsForSubject[indexPath.section][indexPath.row].image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (self.sectionTitles.count != 0) {
            return sectionTitles[section]
        }else{
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.textLabel?.font = UIFont.fontAwesome(ofSize: 26)
        header.textLabel?.text = String.fontAwesomeIcon(code: iconSections[section])! + " " + sectionTitles[section]

        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        
        let headerFrame = self.view.frame.size
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 0, width: 22, height: 22));
        theImageView.image = UIImage(named: "Chevron-Dn-Wht")
        theImageView.tag = kHeaderSectionTag + section
        
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(CoursesDetailViewController.sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func loadView() {
        super.loadView()
        
        optionsForSubject.append([])
        optionsForSubject.append([])
        optionsForSubject.append([])
        optionsForSubject.append([])
        optionsForSubject[0].append(Option(name: "Introducción", image: "fa-info", segue: "introduction"))
        optionsForSubject[0].append(Option(name: "Guía Docente" , image: "fa-file-text", segue: "guide"))
        optionsForSubject[0].append(Option(name: "Programa de teoría" , image: "fa-list-ol", segue: "lectures"))
        optionsForSubject[0].append(Option(name: "Programa de Prácticas" , image: "fa-flask", segue: "practicals"))
        optionsForSubject[2].append(Option(name: "Documentos" , image: "fa-folder-open", segue: "documents"))
        optionsForSubject[2].append(Option(name: "Archivos compartidos" , image: "fa-folder-open", segue: "shared"))
        optionsForSubject[0].append(Option(name: "Bibliografia" , image: "fa-book", segue: "bibliography"))
        optionsForSubject[0].append(Option(name: "FAQs" , image: "fa-question", segue: "FAQ"))
        optionsForSubject[0].append(Option(name: "Enlaces" , image: "fa-link", segue: "links"))
        optionsForSubject[1].append(Option(name: "Sistema de Evaluación" , image: "fa-info", segue: "assessment"))
        optionsForSubject[1].append(Option(name: "Calificaciones" , image: "fa-list-alt", segue: "marks"))
        optionsForSubject[3].append(Option(name: "Generar QR" , image: "fa-qrcode", segue: "qr"))
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        switch segue.identifier!{
        case "configuration":
            break
        case "introduction":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseInformation
            break
        case "guide":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseGuide
            break
        case "lectures":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseLectures
            break
        case "practicals":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = coursePracticals
            break
        case "bibliography":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseBibliography
            break
        case "FAQ":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseFAQ
            break
        case "links":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseLinks
            destinationVC.enlaces = true
            break
        case "assessment":
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseAssessment
            break
        case "documents":
            let destinationVC = segue.destination as! DocumentsViewController
            let t = Root(xmlTree: self.documents)
            destinationVC.node = t.root
            destinationVC.actualNode = t.root
            destinationVC.marks = false

            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = optionsForSubject[0][indexPath.row]
                destinationVC.detailItem = object
            }
            break
        case "shared":
            let destinationVC = segue.destination as! DocumentsViewController
            let t = Root(xmlTree: self.shared)
            destinationVC.node = t.root
            destinationVC.actualNode = t.root
            destinationVC.marks = false
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = optionsForSubject[0][indexPath.row]
                destinationVC.detailItem = object
            }
            break;
        case "marks":
            let destinationVC = segue.destination as! DocumentsViewController
            let t = Root(xmlTree: self.marks)
            destinationVC.node = t.root
            destinationVC.actualNode = t.root
            destinationVC.marks = false
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = optionsForSubject[1][indexPath.row]
                destinationVC.detailItem = object
            }
            break;
        case "qr":
            let destinationVC = segue.destination as! QrViewController
            break;
        default:
            let destinationVC = segue.destination as! InfoViewController
            destinationVC.info = courseInformation
            break
        }
        
        if let detail = self.detailItem as? CoursesMasterViewController.Course {
            let backItem = UIBarButtonItem()
            backItem.title = detail.name
            navigationItem.backBarButtonItem = backItem
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if optionsForSubject[indexPath.section][indexPath.row].segue != "" {
            performSegue(withIdentifier: optionsForSubject[indexPath.section][indexPath.row].segue, sender: nil)
        }
    }
    
    /**
        Method that get the information given a course and the type of information you want
     
        - parameter courseCode:    code that identifies the course
        - parameter infoType:        type of information that you want from the course
     */
    func getCourseInfo(_ courseCode: Int, infoType: String) -> Void {
        let client = SyedAbsarClient()
        let defaults = UserDefaults.standard
        
        let requestInfo = GetCourseInfo()
        requestInfo.cpWsKey = defaults.string(forKey: Constants.wsKey)
        requestInfo.cpCourseCode = courseCode
        requestInfo.cpInfoType = infoType
    
        client.opGetCourseInfo(requestInfo){ (error, response3) in
            switch infoType{
            case "introduction":
                self.courseInformation = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "guide":
                self.courseGuide = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "lectures":
                self.courseLectures = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "practicals":
                self.coursePracticals = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "bibliography":
                self.courseBibliography = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "FAQ":
                self.courseFAQ = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "links":
                self.courseLinks = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            case "assessment":
                self.courseAssessment = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            default:
                self.courseGuide = (response3!["getCourseInfoOutput"]["infoTxt"].element?.text)!
                break
            }
        }
    }
    
    /**
        Method that get the tree directory documents given a course
     
     - parameter courseCode:    code that identifies the course
     - parameter treeCode:  type of tree that you want from the course
     - parameter groupCode: code of group course
     */
    func getCourseDocument(_ courseCode: Int, treeCode: Int, groupCode:Int = 0) -> Void {
        let client = SyedAbsarClient()
        let defaults = UserDefaults.standard
        
        let requestDocumnets = GetDirectoryTree()
        requestDocumnets.cpWsKey = defaults.string(forKey: Constants.wsKey)
        requestDocumnets.cpCourseCode = courseCode
        requestDocumnets.cpTreeCode = treeCode
        requestDocumnets.cpGroupCode = groupCode
        
        client.opGetDirectoryTree(requestDocumnets){ (error, response3) in
            switch treeCode{
            case 1:
                self.documents = (response3!["getDirectoryTreeOutput"]["tree"].element?.text)!
                break
            case 2:
                self.shared = (response3!["getDirectoryTreeOutput"]["tree"].element?.text)!
                break
            case 3:
                self.marks = (response3!["getDirectoryTreeOutput"]["tree"].element?.text)!
                break
            default:
                break
            }
        }
    }
    
    /**
      method that controls the event by touching the title of the sections of each subject, expanding or collapsing the submenus
     */
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    /**
     method that collapses a section of a subject
    */
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.optionsForSubject[section] as NSArray
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.tableView!.beginUpdates()
            self.tableView!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
    
    /**
     method that expands a section of a subject
    */
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        let sectionData = self.optionsForSubject[section] as NSArray
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.tableView!.beginUpdates()
            self.tableView!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            self.tableView!.endUpdates()
        }
    }
}
