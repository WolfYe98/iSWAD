//
//  UserListsViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 30/3/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//

import UIKit
class UserListsViewController: UIViewController {
    var attendanceCode:Int?
    var textInformation : UILabel!
    var refresh = UIRefreshControl()
    var students:[AttendanceUser] = [AttendanceUser]()
    var attendancedStudentCodes : [Int] = [Int]()
    var dic_users = [Int:Bool]()
    
    weak var qrDelegate : QrReaderViewControllerDelegate?
    
    @IBOutlet weak var qrReader: UIBarButtonItem!
    @IBOutlet weak var sendUsers: UIBarButtonItem!
    @IBOutlet weak var tablaEstudiantes: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set bar button icons and text color.
        self.title = "Estudiantes"
        let fontAttributes = [NSAttributedStringKey.font : UIFont.fontAwesome(ofSize: 25)] as Dictionary?
        
        
        self.qrReader.setTitleTextAttributes(fontAttributes, for: .normal)
        self.qrReader.tintColor = .black
        self.qrReader.title = String.fontAwesomeIcon(name: .qrcode)
        
        self.sendUsers.setTitleTextAttributes(fontAttributes, for: .normal)
        self.sendUsers.tintColor = .black
        self.sendUsers.title = String.fontAwesomeIcon(name: .send)
        
        
        self.textInformation = createInfoLabel(self.view, message: "Desliza hacia abajo para cargar la lista de estudiantes", textSize: 23)
        self.tablaEstudiantes.addSubview(self.textInformation)
        
        
        refresh.attributedTitle = NSAttributedString(string: "Cargando")
        refresh.addTarget(self, action: #selector(self.getData(_:)), for: .valueChanged)
        self.tablaEstudiantes.addSubview(self.refresh)
        
        self.tablaEstudiantes.tableFooterView = UIView()
        self.tablaEstudiantes.dataSource = self
        self.tablaEstudiantes.delegate = self
        self.tablaEstudiantes.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    
    //Selectors
    @objc func getData(_ sender: AnyObject){
        let defaults = UserDefaults.standard
        let client = SyedAbsarClient()
        let request = GetAttendanceUsers()
        request.cpWsKey = defaults.string(forKey: Constants.wsKey)
        request.cpAttendanceEventCode = self.attendanceCode!
        client.opGetAttendanceUsers(request){error,response in
            if error != nil{
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    showAlert(self, message: error!.localizedDescription, 1, handler: {boleano in
                        self.refresh.endRefreshing()
                    })
                }
                return
            }
            let userArray = response!["getAttendanceUsersOutput"]["usersArray"].children
           
            for item in userArray{
                
                let key = Int((item["userCode"].element?.text)!)!
                if self.dic_users.keys.contains(key){
                    for st in self.students{
                        if st.cpUserCode != key{continue}
                        st.cpPresent = Int((item["present"].element?.text)!)
                        st.cpUserPhoto = item["userPhoto"].element?.text
                    }
                    continue
                }
                
                self.dic_users[key] = true
                let user = AttendanceUser()
                user.cpUserCode = Int((item["userCode"].element?.text)!)
                user.cpUserNickname = item["userNickname"].element?.text
                user.cpUserID = item["userID"].element?.text
                user.cpUserSurname1 = item["userSurname1"].element?.text
                user.cpUserSurname2 = item["userSurname2"].element?.text
                user.cpUserFirstname = item["userFirstname"].element?.text
                user.cpUserPhoto = item["userPhoto"].element?.text
                user.cpPresent = Int((item["present"].element?.text)!)
                
                self.students.append(user)
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                self.refresh.endRefreshing()
                self.tablaEstudiantes.reloadData()
            }
        }
    }
    
    //Actions
    @IBAction func sendList(_ sender: Any) {
        var users = " "
        var men = "¿Quieres marcar todos los demás como NO asistidos (Incluyendo los alumnos que estaban ya marcados)?"
        let client = SyedAbsarClient()
        let request = SendAttendanceUsers()
        let defaults = UserDefaults.standard
        var setOtherAsAbsent = 0
        for st in self.attendancedStudentCodes{
            users = users + String(st) + ","
        }
        if self.tablaEstudiantes.visibleCells.count > 0{
            if self.attendancedStudentCodes.count > 0{
                users.remove(at: users.lastIndex(of: ",")!)
                users.remove(at: users.index(of: " ")!)
            }
            else{
                men = "¿Marcar a todos como NO asistidos?"
            }
            showAlert(self, message:men , 2,"Sí","No", handler: {boleano in
                if boleano{
                    setOtherAsAbsent = 1
                }
                request.cpWsKey = defaults.string(forKey: Constants.wsKey)
                request.cpUsers = users
                request.cpAttendanceEventCode = self.attendanceCode!
                request.cpSetOthersAsAbsent = setOtherAsAbsent
                
                client.opSendAttendanceUsers(request){error,response in
                    if error != nil{
                        showAlert(self, message: error!.localizedDescription, 1, handler:{boleano in})
                        return
                    }
                    if Int((response!["sendAttendanceUsersOutput"]["success"].element?.text)!) == 0{
                        showAlert(self, message: "Ha ocurrido un error!", 1,"Entendido", handler: {booleano in})
                    }
                }
                self.students.removeAll()
                self.attendancedStudentCodes.removeAll()
                self.dic_users.removeAll()
                self.textInformation = createInfoLabel(self.tablaEstudiantes, message: "Desliza hacia abajo para cargar la lista de estudiantes", textSize: 23)
                DispatchQueue.main.asyncAfter(deadline: .now()){
                    self.tablaEstudiantes.addSubview(self.textInformation)
                    self.tablaEstudiantes.addSubview(self.refresh)
                    self.tablaEstudiantes.reloadData()
                }
            })
        }
    }
    
    @IBAction func qrReaderAction(_ sender: Any) {
        if self.students.count == 0{
            showAlert(self, message: "No has cargado aún la lista de estudiantes!", 1, "OK",handler: {boleano in})
            return
        }
        self.performSegue(withIdentifier: "toReader", sender: self)
    }
    
    
    //Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! QrReaderViewController
        var codes = [String]()
        var codeUrl = [String:String]()
        
        for st in self.students{
            codes.append("@"+st.cpUserNickname!)
            codeUrl["@"+st.cpUserNickname!] = st.cpUserPhoto!
        }
        destino.codes = codes
        destino.delegate = self
        destino.codeUrls = codeUrl
    }
}


extension UserListsViewController:UITableViewDataSource,UITableViewDelegate,QrReaderViewControllerDelegate,CheckBoxDelegate{
    func addCode(_ code: Int) {
        if !self.attendancedStudentCodes.contains(code){
            self.attendancedStudentCodes.append(code)
        }
    }
    func removeCode(_ code: Int) {
        if self.attendancedStudentCodes.contains(code){
            self.attendancedStudentCodes.remove(at: self.attendancedStudentCodes.index(of: code)!)
        }
    }
    func codeReaded(_ codes: [String]) {
        for st in self.students{
            if !codes.contains("@" + st.cpUserNickname!){continue}
            st.cpPresent = 1
        }
        DispatchQueue.main.asyncAfter(deadline:.now()){
            self.tablaEstudiantes.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaEstudiantes.dequeueReusableCell(withIdentifier: "UserCell") as! UserTableViewCell
        if self.students.count > 0{
            var imagen :UIImage!
            cell.imagen.image = UIImage(named: "nouserswad")
            if let strURL = self.students[indexPath.row].cpUserPhoto{
                let url = URL(string: strURL)
                    if let urlaux = url{
                        if let datos = try? Data(contentsOf: urlaux){
                        imagen = UIImage(data: datos)
                        if imagen != nil{
                            cell.imagen.image = imagen
                        }
                    }
                
                }
            }
           
            cell.name.text = self.students[indexPath.row].cpUserSurname2! + " " + self.students[indexPath.row].cpUserSurname1! + ",\n" + self.students[indexPath.row].cpUserFirstname!
            cell.nickname.text = "@" + self.students[indexPath.row].cpUserNickname!
            cell.id.text = self.students[indexPath.row].cpUserID
            
            cell.checkBox.code = self.students[indexPath.row].cpUserCode!
            cell.checkBox.isChecked = true
            if self.students[indexPath.row].cpPresent! == 0{
                cell.checkBox.isChecked = false
            }
            cell.checkBox.delegate = self
            self.textInformation.removeFromSuperview()
            self.refresh.removeFromSuperview()
        }
        return cell
    }
   
    // Make rows not selectable
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}
