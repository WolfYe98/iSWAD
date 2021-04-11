//
//  QrReaderViewController.swift
//  iSWAD
//
//  Created by Bate Ye on 2/4/21.
//  Copyright © 2021 Adrián Lara Roldán. All rights reserved.
//
import AVFoundation
import UIKit

protocol QrReaderViewControllerDelegate: AnyObject{
    func codeReaded(_ codes: [String])
}

class QrReaderViewController: UIViewController {

    var captureSession : AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrView :UIView!
    var codes = [String]()
    var readedCodes = [String]()
    var informationVC : InformationAlertViewController!
    var codeUrls = [String:String]()
    var presentado = false
    var lastCode : String!
    
    weak var delegate : QrReaderViewControllerDelegate?
    @IBOutlet weak var QrviewBounds: UIView!
    
    // Overrides functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
        
        //Creating a capture session
        self.captureSession = AVCaptureSession()
        
        //Setting a device
        guard let device = AVCaptureDevice.default(for: .video) else {return}
        let input : AVCaptureDeviceInput
        do{
            input = try AVCaptureDeviceInput(device:device)
        }catch{
            return
        }
        if captureSession.canAddInput(input){
            captureSession.addInput(input)
        }
        else{
            //Muestra la alerta de error
            return
        }
        
        //Setting the output
        let metadadaOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadadaOutput){
            captureSession.addOutput(metadadaOutput)
            metadadaOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadadaOutput.metadataObjectTypes = [.qr]
        }
        else{
            //alerta aquí
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // Fix rotation
        previewLayer.frame = self.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(previewLayer)
        
        // Add drawn sqare to the reader.
        self.addSquareToQrReader()
        
        // Set the read area to the rectangle.
        self.setQrReaderArea(metadata: metadadaOutput, previewLayer: previewLayer)
        
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if captureSession.isRunning == false{
            captureSession.startRunning()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if captureSession.isRunning == true{
            captureSession.stopRunning()
        }
        delegate?.codeReaded(self.readedCodes)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // Class functions
    func found(code: String) {
        if #available(iOS 13.0, *) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            self.informationVC = storyBoard.instantiateViewController(identifier: "informationVC")
            self.informationVC!.modalPresentationStyle = .overCurrentContext
            self.informationVC!.modalTransitionStyle = .crossDissolve
        } else {
            showAlert(self, message: "ATENCIÓN: con su versión actual de iOS no se va a mostrar la imagen del estudiante", 1, handler: {boleano in})
            return
        }
        if !self.codes.contains(code) && self.qrView.layer.borderColor != UIColor.red.cgColor{
            AudioServicesPlayAlertSound(1053)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.qrView.layer.borderColor = UIColor.red.cgColor
            self.informationVC!.error = true
        }
        else if self.codes.contains(code) && self.qrView.layer.borderColor != UIColor.green.cgColor{
            // Here goes the code for mark the student
            AudioServicesPlayAlertSound(1114)
            self.qrView.layer.borderColor = UIColor.green.cgColor
            self.readedCodes.append(code)
            self.informationVC!.error = false
            if let url = URL(string: codeUrls[code]!){
                self.informationVC!.url = url
            }
        }
    }
    func addSquareToQrReader(){
        // put a little square in camera
        qrView = UIView()
        qrView.frame = QrviewBounds.frame
        qrView.center = CGPoint(x:self.view.frame.width/2,y:self.view.frame.height/2)
        QrviewBounds.removeFromSuperview()
        qrView.layer.borderColor = UIColor.gray.cgColor
        qrView.layer.borderWidth = 3
        qrView.layer.cornerRadius = 20
        self.view.addSubview(qrView)
        self.view.bringSubview(toFront: qrView)
    }
    func setQrReaderArea(metadata : AVCaptureMetadataOutput,previewLayer : AVCaptureVideoPreviewLayer){
        // Set the read area to the rectangle.
        let rect = CGRect(x: qrView.center.x-(qrView.bounds.width/2)-20, y: qrView.center.y-(qrView.bounds.height/2)-20, width: qrView.bounds.width+20, height: qrView.bounds.height+20)
        metadata.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: rect)
    }

}


extension QrReaderViewController:AVCaptureMetadataOutputObjectsDelegate{
    // Read the qr code value
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            if stringValue != lastCode{
                self.presentado = false
                self.dismiss(animated: true, completion: {})
            }

            found(code: stringValue)
            lastCode = stringValue
            
            if !self.presentado{
                self.present(self.informationVC!, animated: true, completion: {})
                self.presentado = true
            }
        }
        else{
            if self.presentado{
                self.presentado = false
                self.dismiss(animated: true, completion: {})
            }
            if self.qrView.layer.borderColor != UIColor.gray.cgColor{
                self.qrView.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
}
