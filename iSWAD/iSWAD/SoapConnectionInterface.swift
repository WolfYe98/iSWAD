//
//  SoapConnectionInterface.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//
//  Modified by Adrián Lara Roldán on 07/08/18.
//  Modified by Bate Ye on 24/03/2021
import Foundation
import SWXMLHash

// Bate Ye: Las clases los dejo arriba porque pienso que es más legible.

// Bate Ye: This classes is for get and store games from SWAD Server
@objc(Game)
open class Game:SyedAbsarObjectBase{
    var gameCode : Int?
    var userSurname1 : String?
    var userSurname2 : String?
    var userFirstName : String?
    var userPhoto : String?
    var startTime : Int32?
    var endTime : Int32?
    var title : String?
    var text : String?
    var numQuestions : Int?
    var maxGrade : Float?
    override static func cpKeys() -> Array<String> {
        return ["GameCode","UserSurname1","UserSurname2","UserFirstName","UserPhoto","StartTime","EndTime","Title","Text","NumQuestions","MaxGrade"]
    }
}
@objc(GetGames)
open class GetGames:SyedAbsarObjectBase{
    var cpWsKey : String?
    var cpCourseCode : Int?
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode"]
    }
}


// Bate Ye: This classes is for get and store matches of a game
// This class doesn't store user informations because the app will pass first to the Game class which store those datas.
@objc(Match)
open class Match:SyedAbsarObjectBase{
    var matchCode : Int?
    var startTime:Int32?
    var endTime:Int32?
    var title:String?
    var questionIndex:Int?
    
    override static func cpKeys() -> Array<String> {
        return ["MatchCode","StartTime","EndTime","Title","QuestionIndex"]
    }
}
@objc(GetMatches)
open class GetMatches:SyedAbsarObjectBase{
    var cpWsKey:String?
    var cpCourseCode:Int?
    var cpGameCode:Int?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","GameCode"]
    }
}
open class SyedAbsarClient {
    
    /**
     Calls the SOAP Operation: CreateAccount with Message based on CreateAccount Object.
     
     - parameter createAccount:  CreateAccount Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opCreateAccount(_ createAccount : CreateAccount , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:createAccount><userNickname>%@</userNickname><userEmail>%@</userEmail><userPassword>%@</userPassword><appKey>%@</appKey></ns1:createAccount></SOAP-ENV:Body></SOAP-ENV:Envelope>",createAccount.cpUserNickname!,createAccount.cpUserEmail!,createAccount.cpUserPassword!,createAccount.cpAppKey!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"CreateAccountOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error, response) })
    }
    
    /**
     Calls the SOAP Operation: LoginByUserPasswordKey with Message based on LoginByUserPasswordKey Object.
     
     - parameter loginByUserPasswordKey:  LoginByUserPasswordKey Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opLoginByUserPasswordKey(_ loginByUserPasswordKey : LoginByUserPasswordKey , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:loginByUserPasswordKey><userID>%@</userID><userPassword>%@</userPassword><appKey>%@</appKey></ns1:loginByUserPasswordKey></SOAP-ENV:Body></SOAP-ENV:Envelope>",loginByUserPasswordKey.cpUserID!,loginByUserPasswordKey.cpUserPassword!,loginByUserPasswordKey.cpAppKey!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"LoginByUserPasswordKeyOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: LoginBySessionKey with Message based on LoginBySessionKey Object.
     
     - parameter loginBySessionKey:  LoginBySessionKey Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opLoginBySessionKey(_ loginBySessionKey : LoginBySessionKey , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:loginBySessionKey><sessionID>%@</sessionID><appKey>%@</appKey></ns1:loginBySessionKey></SOAP-ENV:Body></SOAP-ENV:Envelope>",loginBySessionKey.cpSessionID!,loginBySessionKey.cpAppKey!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"LoginBySessionKeyOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetNewPassword with Message based on GetNewPassword Object.
     
     - parameter getNewPassword:  GetNewPassword Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetNewPassword(_ getNewPassword : GetNewPassword , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getNewPassword><userID>%@</userID><appKey>%@</appKey></ns1:getNewPassword></SOAP-ENV:Body></SOAP-ENV:Envelope>",getNewPassword.cpUserID!,getNewPassword.cpAppKey!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetNewPasswordOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetCourses with Message based on GetCourses Object.
     
     - parameter getCourses:  GetCourses Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetCourses(_ getCourses : GetCourses , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getCourses><wsKey>%@</wsKey></ns1:getCourses></SOAP-ENV:Body></SOAP-ENV:Envelope>",getCourses.cpWsKey!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetCoursesOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetCourseInfo with Message based on GetCourseInfo Object.
     
     - parameter getCourseInfo:  GetCourseInfo Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetCourseInfo(_ getCourseInfo : GetCourseInfo , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getCourseInfo><wsKey>%@</wsKey><courseCode>%d</courseCode><infoType>%@</infoType></ns1:getCourseInfo></SOAP-ENV:Body></SOAP-ENV:Envelope>",getCourseInfo.cpWsKey!,getCourseInfo.cpCourseCode,getCourseInfo.cpInfoType!)
        //let soapMessage = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getCourseInfo><wsKey>\(getCourseInfo.cpWsKey)</wsKey><courseCode>%@</courseCode><infoType>%@</infoType></ns1:getCourseInfo></SOAP-ENV:Body></SOAP-ENV:Envelope>",getCourseInfo.cpWsKey!,getCourseInfo.cpCourseCode,getCourseInfo.cpInfoType!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetCourseInfoOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetGroupTypes with Message based on GetGroupTypes Object.
     
     - parameter getGroupTypes:  GetGroupTypes Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetGroupTypes(_ getGroupTypes : GetGroupTypes , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getGroupTypes><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getGroupTypes></SOAP-ENV:Body></SOAP-ENV:Envelope>",getGroupTypes.cpWsKey!,getGroupTypes.cpCourseCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetGroupTypesOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetGroups with Message based on GetGroups Object.
     
     - parameter getGroups:  GetGroups Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetGroups(_ getGroups : GetGroups , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getGroups><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getGroups></SOAP-ENV:Body></SOAP-ENV:Envelope>",getGroups.cpWsKey!,getGroups.cpCourseCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetGroupsOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: SendMyGroups with Message based on SendMyGroups Object.
     
     - parameter sendMyGroups:  SendMyGroups Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opSendMyGroups(_ sendMyGroups : SendMyGroups , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendMyGroups><wsKey>%@</wsKey><courseCode>0</courseCode><myGroups>%@</myGroups></ns1:sendMyGroups></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendMyGroups.cpWsKey!,sendMyGroups.cpCourseCode,sendMyGroups.cpMyGroups!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendMyGroupsOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetDirectoryTree with Message based on GetDirectoryTree Object.
     
     - parameter getDirectoryTree:  GetDirectoryTree Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetDirectoryTree(_ getDirectoryTree : GetDirectoryTree , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getDirectoryTree><wsKey>%@</wsKey><courseCode>%d</courseCode><groupCode>%d</groupCode><treeCode>%d</treeCode></ns1:getDirectoryTree></SOAP-ENV:Body></SOAP-ENV:Envelope>",getDirectoryTree.cpWsKey!,getDirectoryTree.cpCourseCode,getDirectoryTree.cpGroupCode,getDirectoryTree.cpTreeCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetDirectoryTreeOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetFile with Message based on GetFile Object.
     
     - parameter getFile:  GetFile Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetFile(_ getFile : GetFile , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getFile><wsKey>%@</wsKey><fileCode>%d</fileCode></ns1:getFile></SOAP-ENV:Body></SOAP-ENV:Envelope>",getFile.cpWsKey!,getFile.cpFileCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetFileOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetMarks with Message based on GetMarks Object.
     
     - parameter getMarks:  GetMarks Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetMarks(_ getMarks : GetMarks , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getMarks><wsKey>%@</wsKey><fileCode>%d</fileCode></ns1:getMarks></SOAP-ENV:Body></SOAP-ENV:Envelope>",getMarks.cpWsKey!,getMarks.cpFileCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetMarksOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetTestConfig with Message based on GetTestConfig Object.
     
     - parameter getTestConfig:  GetTestConfig Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetTestConfig(_ getTestConfig : GetTestConfig , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getTestConfig><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getTestConfig></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTestConfig.cpWsKey!,getTestConfig.cpCourseCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetTestConfigOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetTests with Message based on GetTests Object.
     
     - parameter getTests:  GetTests Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetTests(_ getTests : GetTests , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getTests><wsKey>%@</wsKey><courseCode>0</courseCode><beginTime>0</beginTime></ns1:getTests></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTests.cpWsKey!,getTests.cpCourseCode,getTests.cpBeginTime!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetTestsOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetTrivialQuestion with Message based on GetTrivialQuestion Object.
     
     - parameter getTrivialQuestion:  GetTrivialQuestion Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetTrivialQuestion(_ getTrivialQuestion : GetTrivialQuestion , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getTrivialQuestion><wsKey>%@</wsKey><degrees>%@</degrees><lowerScore>0</lowerScore><upperScore>0</upperScore></ns1:getTrivialQuestion></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTrivialQuestion.cpWsKey!,getTrivialQuestion.cpDegrees!,getTrivialQuestion.cpLowerScore!,getTrivialQuestion.cpUpperScore!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetTrivialQuestionOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetUsers with Message based on GetUsers Object.
     
     - parameter getUsers:  GetUsers Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetUsers(_ getUsers : GetUsers , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getUsers><wsKey>%@</wsKey><courseCode>0</courseCode><groupCode>0</groupCode><userRole>0</userRole></ns1:getUsers></SOAP-ENV:Body></SOAP-ENV:Envelope>",getUsers.cpWsKey!,getUsers.cpCourseCode,getUsers.cpGroupCode,getUsers.cpUserRole)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetUsersOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetAttendanceEvents with Message based on GetAttendanceEvents Object.
     
     - parameter getAttendanceEvents:  GetAttendanceEvents Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetAttendanceEvents(_ getAttendanceEvents : GetAttendanceEvents , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getAttendanceEvents><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getAttendanceEvents></SOAP-ENV:Body></SOAP-ENV:Envelope>",getAttendanceEvents.cpWsKey!,getAttendanceEvents.cpCourseCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetAttendanceEventsOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: SendAttendanceEvent with Message based on SendAttendanceEvent Object.
     
     - parameter sendAttendanceEvent:  SendAttendanceEvent Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opSendAttendanceEvent(_ sendAttendanceEvent : SendAttendanceEvent , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendAttendanceEvent><wsKey>%@</wsKey><attendanceEventCode>0</attendanceEventCode><courseCode>0</courseCode><hidden>0</hidden><startTime>0</startTime><endTime>0</endTime><commentsTeachersVisible>0</commentsTeachersVisible><title>%@</title><text>%@</text><groups>%@</groups></ns1:sendAttendanceEvent></SOAP-ENV:Body></SOAP-ENV:Envelope>",
                                 sendAttendanceEvent.cpWsKey!,
                                 sendAttendanceEvent.cpAttendanceEventCode,
                                 sendAttendanceEvent.cpCourseCode,
                                 sendAttendanceEvent.cpHidden,
                                 sendAttendanceEvent.cpStartTime,
                                 sendAttendanceEvent.cpEndTime,
                                 sendAttendanceEvent.cpCommentsTeachersVisible,
                                 sendAttendanceEvent.cpTitle!,
                                 sendAttendanceEvent.cpText!,
                                 sendAttendanceEvent.cpGroups!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendAttendanceEventOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetAttendanceUsers with Message based on GetAttendanceUsers Object.
     
     - parameter getAttendanceUsers:  GetAttendanceUsers Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetAttendanceUsers(_ getAttendanceUsers : GetAttendanceUsers , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getAttendanceUsers><wsKey>%@</wsKey><attendanceEventCode>0</attendanceEventCode></ns1:getAttendanceUsers></SOAP-ENV:Body></SOAP-ENV:Envelope>",getAttendanceUsers.cpWsKey!,getAttendanceUsers.cpAttendanceEventCode)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetAttendanceUsersOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: SendAttendanceUsers with Message based on SendAttendanceUsers Object.
     
     - parameter sendAttendanceUsers:  SendAttendanceUsers Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opSendAttendanceUsers(_ sendAttendanceUsers : SendAttendanceUsers , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendAttendanceUsers><wsKey>%@</wsKey><attendanceEventCode>0</attendanceEventCode><users>%@</users><setOthersAsAbsent>0</setOthersAsAbsent></ns1:sendAttendanceUsers></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendAttendanceUsers.cpWsKey!,sendAttendanceUsers.cpAttendanceEventCode,sendAttendanceUsers.cpUsers!,sendAttendanceUsers.cpSetOthersAsAbsent)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendAttendanceUsersOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetNotifications with Message based on GetNotifications Object.
     
     - parameter getNotifications:  GetNotifications Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetNotifications(_ getNotifications : GetNotifications , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getNotifications><wsKey>%@</wsKey><beginTime>%d</beginTime></ns1:getNotifications></SOAP-ENV:Body></SOAP-ENV:Envelope>",getNotifications.cpWsKey!,getNotifications.cpBeginTime!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetNotificationsOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: MarkNotificationsAsRead with Message based on MarkNotificationsAsRead Object.
     
     - parameter markNotificationsAsRead:  MarkNotificationsAsRead Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opMarkNotificationsAsRead(_ markNotificationsAsRead : MarkNotificationsAsRead , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:markNotificationsAsRead><wsKey>%@</wsKey><notifications>%@</notifications></ns1:markNotificationsAsRead></SOAP-ENV:Body></SOAP-ENV:Envelope>",markNotificationsAsRead.cpWsKey!,markNotificationsAsRead.cpNotifications!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"MarkNotificationsAsReadOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: SendNotice with Message based on SendNotice Object.
     
     - parameter sendNotice:  SendNotice Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opSendNotice(_ sendNotice : SendNotice , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendNotice><wsKey>%@</wsKey><courseCode>0</courseCode><body>%@</body></ns1:sendNotice></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendNotice.cpWsKey!,sendNotice.cpCourseCode,sendNotice.cpBody!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendNoticeOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: SendMessage with Message based on SendMessage Object.
     
     - parameter sendMessage:  SendMessage Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opSendMessage(_ sendMessage : SendMessage , completionHandler: @escaping (NSError?, XMLIndexer?) -> Void) {
        
        
        let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendMessage><wsKey>%@</wsKey><messageCode>%@</messageCode><to>%@</to><subject>%@</subject><body>%@</body></ns1:sendMessage></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendMessage.cpWsKey!,sendMessage.cpMessageCode!,sendMessage.cpTo!,sendMessage.cpSubject!,sendMessage.cpBody!)
        
        self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendMessageOutput", completionHandler: { (error: NSError?, response:XMLIndexer? )->Void in completionHandler(error,response) })
    }
    
    /**
     Calls the SOAP Operation: GetGames with Message based on GetGames Object
     
     - parameter getGames:  GetGames Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetGames(_ getGames: GetGames, completionHandler: @escaping (NSError?, XMLIndexer?)->Void){
        if getGames.cpWsKey != nil && getGames.cpCourseCode != nil{
            let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getGames><wsKey>%@</wsKey><courseCode>%d</courseCode></ns1:getGames></SOAP-ENV:Body></SOAP-ENV:Envelope>",getGames.cpWsKey!,getGames.cpCourseCode!)
            self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className: "GetGames", completionHandler: completionHandler)
        }
    }
    
    /**
     Calls the SOAP Operation: GetMatches with Message based on GetGames Object
     
     - parameter getGames:  GetMatches Object.
     - parameter completionHandler:  The Callback Handler.
     
     - returns: Void.
     */
    open func opGetMatches(_ getMatches: GetMatches, completionHandler: @escaping (NSError?, XMLIndexer?)->Void){
        if getMatches.cpWsKey != nil && getMatches.cpCourseCode != nil && getMatches.cpGameCode != nil{
            let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getMatches><wsKey>%@</wsKey><courseCode>%d</courseCode><gameCode>%d</gameCode></ns1:getMatches></SOAP-ENV:Body></SOAP-ENV:Envelope>",getMatches.cpWsKey!,getMatches.cpCourseCode!,getMatches.cpGameCode!)
            self.makeSoapConnection(getServerURL(), soapAction: "", soapMessage: soapMessage, soapVersion: "1", className: "GetGames", completionHandler: completionHandler)
        }
    }
    /**
     Private Method: Make Soap Connection.
     
     - parameter soapLocation: String.
     - soapAction: String.
     - soapMessage: String.
     - soapVersion: String (1.1 Or 1.2).
     - className: String.
     - completionHandler: Handler.
     - returns: Void.
     */
    fileprivate func makeSoapConnection(_ soapLocation: String, soapAction: String, soapMessage: String,  soapVersion: String, className: String, completionHandler: @escaping (NSError?, XMLIndexer?) -> Void){
        let Location = soapLocation
        
        let url = URL(string: Location)
        var request = URLRequest(url: url!)
        let msgLength  = String(soapMessage.count)
        let data = Data(soapMessage.utf8)
        
        request.httpMethod = "POST"
        request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        
        request.httpBody = data
        
        
        
        let task2 = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            let datastring = String(decoding: data!, as: UTF8.self)
            let aClass = NSClassFromString(className) as! SyedAbsarObjectBase.Type
            
            var xml = SWXMLHash.config { conf in
                conf.shouldProcessNamespaces = true
                }.parse(datastring)
            
            let obj = aClass
            
            let inst = obj.newInstance()
            inst.xmlResponseString = "\(datastring)"
            
            var error : NSError?
            
            let soapFault = xml["Envelope"]["Body"]["Fault"]
            if  soapFault["detail"].element?.text != nil {
                let val =  soapFault["detail"].element?.text
                error =  NSError(domain: "soapFault", code: 0, userInfo: NSDictionary(object: val!, forKey: NSLocalizedDescriptionKey as NSCopying) as! [AnyHashable : Any] as [AnyHashable: Any] as? [String : Any])
            }
            xml =  xml["Envelope"]["Body"]
            completionHandler(error, xml)
        })
        task2.resume()
    }
    
    
    
    
}
/**
 Course.
 */
@objc(Course)
open class Course : SyedAbsarObjectBase {
    
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Course Short Name
    var cpCourseShortName: String?
    
    /// Course Full Name
    var cpCourseFullName: String?
    
    /// User Role
    var cpUserRole: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["CourseCode","CourseShortName","CourseFullName","UserRole"]
    }
}

/**
 Courses Array.
 */
@objc(CoursesArray)
open class CoursesArray : SyedAbsarObjectBase {
    
    required public init() {
        cpItem = []
    }
    /// Item
    var cpItem: [Course]
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Group Type.
 */
@objc(GroupType)
open class GroupType : SyedAbsarObjectBase {
    
    
    /// Group Type Code
    var cpGroupTypeCode: Int = 0
    
    /// Group Type Name
    var cpGroupTypeName: String?
    
    /// Mandatory
    var cpMandatory: Int = 0
    
    /// Multiple
    var cpMultiple: Int = 0
    
    /// Open Time
    var cpOpenTime: CLong?
    
    override static func cpKeys() -> Array<String> {
        return ["GroupTypeCode","GroupTypeName","Mandatory","Multiple","OpenTime"]
    }
}

/**
 Group Types Array.
 */
@objc(GroupTypesArray)
open class GroupTypesArray : SyedAbsarObjectBase {
    
    required public init() {
        cpItem = []
    }
    
    /// Item
    var cpItem: [GroupType]
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Group.
 */
@objc(Group)
open class Group : SyedAbsarObjectBase {
    
    
    /// Group Code
    var cpGroupCode: Int = 0
    
    /// Group Name
    var cpGroupName: String?
    
    /// Group Type Code
    var cpGroupTypeCode: Int = 0
    
    /// Group Type Name
    var cpGroupTypeName: String?
    
    /// Open
    var cpOpen: Int = 0
    
    /// Max Students
    var cpMaxStudents: Int = 0
    
    /// Num Students
    var cpNumStudents: Int = 0
    
    /// File Zones
    var cpFileZones: Int = 0
    
    /// Member
    var cpMember: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["GroupCode","GroupName","GroupTypeCode","GroupTypeName","Open","MaxStudents","NumStudents","FileZones","Member"]
    }
}

/**
 Groups Array.
 */
@objc(GroupsArray)
open class GroupsArray : SyedAbsarObjectBase {
    required public init() {
        cpItem = []
    }
    
    /// Item
    var cpItem: [Group]
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Notification.
 */
@objc(Notification)
open class Notification : SyedAbsarObjectBase {
    
    
    /// Notif Code
    var cpNotifCode: Int = 0
    
    /// Event Type
    var cpEventType: String?
    
    /// Event Code
    var cpEventCode: Int = 0
    
    /// Event Time
    var cpEventTime: CLong?
    
    /// User Nickname
    var cpUserNickname: String?
    
    /// User Surname1
    var cpUserSurname1: String?
    
    /// User Surname2
    var cpUserSurname2: String?
    
    /// User Firstname
    var cpUserFirstname: String?
    
    /// User Photo
    var cpUserPhoto: String?
    
    /// Location
    var cpLocation: String?
    
    /// Status
    var cpStatus: Int = 0
    
    /// Summary
    var cpSummary: String?
    
    /// Content
    var cpContent: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NotifCode","EventType","EventCode","EventTime","UserNickname","UserSurname1","UserSurname2","UserFirstname","UserPhoto","Location","Status","Summary","Content"]
    }
}

/**
 Notifications Array.
 */
@objc(NotificationsArray)
open class NotificationsArray : SyedAbsarObjectBase {
    required public init() {
        cpItem = []
    }
    
    /// Item
    var cpItem: [Notification]
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Tag.
 */
@objc(Tag)
open class Tag : SyedAbsarObjectBase {
    
    
    /// Tag Code
    var cpTagCode: Int = 0
    
    /// Tag Text
    var cpTagText: String?
    
    override static func cpKeys() -> Array<String> {
        return ["TagCode","TagText"]
    }
}

/**
 Tags Array.
 */
@objc(TagsArray)
open class TagsArray : SyedAbsarObjectBase {
    required public init() {
        cpItem = []
    }
    
    /// Item
    var cpItem: [Tag]
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Question.
 */
@objc(Question)
open class Question : SyedAbsarObjectBase {
    
    
    /// Question Code
    var cpQuestionCode: Int = 0
    
    /// Answer Type
    var cpAnswerType: String?
    
    /// Shuffle
    var cpShuffle: Int = 0
    
    /// Stem
    var cpStem: String?
    
    /// Feedback
    var cpFeedback: String?
    
    override static func cpKeys() -> Array<String> {
        return ["QuestionCode","AnswerType","Shuffle","Stem","Feedback"]
    }
}

/**
 Questions Array.
 */
@objc(QuestionsArray)
open class QuestionsArray : SyedAbsarObjectBase {
    
    
    /// Item
    var cpItem: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Answer.
 */
@objc(Answer)
open class Answer : SyedAbsarObjectBase {
    
    
    /// Question Code
    var cpQuestionCode: Int = 0
    
    /// Answer Index
    var cpAnswerIndex: Int = 0
    
    /// Correct
    var cpCorrect: Int = 0
    
    /// Answer Text
    var cpAnswerText: String?
    
    /// Answer Feedback
    var cpAnswerFeedback: String?
    
    override static func cpKeys() -> Array<String> {
        return ["QuestionCode","AnswerIndex","Correct","AnswerText","AnswerFeedback"]
    }
}

/**
 Answers Array.
 */
@objc(AnswersArray)
open class AnswersArray : SyedAbsarObjectBase {
    
    
    /// Item
    var cpItem: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Question Tag.
 */
@objc(QuestionTag)
open class QuestionTag : SyedAbsarObjectBase {
    
    
    /// Question Code
    var cpQuestionCode: Int = 0
    
    /// Tag Code
    var cpTagCode: Int = 0
    
    /// Tag Index
    var cpTagIndex: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["QuestionCode","TagCode","TagIndex"]
    }
}

/**
 Question Tags Array.
 */
@objc(QuestionTagsArray)
open class QuestionTagsArray : SyedAbsarObjectBase {
    
    
    /// Item
    var cpItem: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 User.
 */
@objc(User)
open class User : SyedAbsarObjectBase {
    
    
    /// User Code
    var cpUserCode: Int = 0
    
    /// User Nickname
    var cpUserNickname: String?
    
    /// User I D
    var cpUserID: String?
    
    /// User Surname1
    var cpUserSurname1: String?
    
    /// User Surname2
    var cpUserSurname2: String?
    
    /// User Firstname
    var cpUserFirstname: String?
    
    /// User Photo
    var cpUserPhoto: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UserCode","UserNickname","UserID","UserSurname1","UserSurname2","UserFirstname","UserPhoto"]
    }
}

/**
 Users Array.
 */
@objc(UsersArray)
open class UsersArray : SyedAbsarObjectBase {
    
    
    /// Item
    var cpItem: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Attendance Event.
 */
@objc(AttendanceEvent)
open class AttendanceEvent : SyedAbsarObjectBase {
    
    
    /// Attendance Event Code
    var cpAttendanceEventCode: Int = 0
    
    /// Hidden
    var cpHidden: Int = 0
    
    /// User Surname1
    var cpUserSurname1: String?
    
    /// User Surname2
    var cpUserSurname2: String?
    
    /// User Firstname
    var cpUserFirstname: String?
    
    /// User Photo
    var cpUserPhoto: String?
    
    /// Start Time
    var cpStartTime: Int = 0
    
    /// End Time
    var cpEndTime: Int = 0
    
    /// Comments Teachers Visible
    var cpCommentsTeachersVisible: Int = 0
    
    /// Title
    var cpTitle: String?
    
    /// Text
    var cpText: String?
    
    /// Groups
    var cpGroups: String?
    
    override static func cpKeys() -> Array<String> {
        return ["AttendanceEventCode","Hidden","UserSurname1","UserSurname2","UserFirstname","UserPhoto","StartTime","EndTime","CommentsTeachersVisible","Title","Text","Groups"]
    }
}

/**
 Attendance Events Array.
 */
@objc(AttendanceEventsArray)
open class AttendanceEventsArray : SyedAbsarObjectBase {
    
    
    /// Item
    var cpItem: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Attendance User.
 */
@objc(AttendanceUser)
open class AttendanceUser : SyedAbsarObjectBase {
    
    
    /// User Code
    var cpUserCode: Int = 0
    
    /// User Nickname
    var cpUserNickname: String?
    
    /// User I D
    var cpUserID: String?
    
    /// User Surname1
    var cpUserSurname1: String?
    
    /// User Surname2
    var cpUserSurname2: String?
    
    /// User Firstname
    var cpUserFirstname: String?
    
    /// User Photo
    var cpUserPhoto: String?
    
    /// Present
    var cpPresent: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["UserCode","UserNickname","UserID","UserSurname1","UserSurname2","UserFirstname","UserPhoto","Present"]
    }
}

/**
 Attendance Users Array.
 */
@objc(AttendanceUsersArray)
open class AttendanceUsersArray : SyedAbsarObjectBase {
    
    
    /// Item
    var cpItem: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Item"]
    }
}

/**
 Create Account.
 */
@objc(CreateAccount)
open class CreateAccount : SyedAbsarObjectBase {
    
    
    /// User Nickname
    var cpUserNickname: String?
    
    /// User Email
    var cpUserEmail: String?
    
    /// User Password
    var cpUserPassword: String?
    
    /// App Key
    var cpAppKey: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UserNickname","UserEmail","UserPassword","AppKey"]
    }
}

/**
 Create Account Output.
 */
@objc(CreateAccountOutput)
open class CreateAccountOutput : SyedAbsarObjectBase {
    
    
    /// User Code
    var cpUserCode: Int = 0
    
    /// Ws Key
    var cpWsKey: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UserCode","WsKey"]
    }
}

/**
 Login By User Password Key.
 */
@objc(LoginByUserPasswordKey)
open class LoginByUserPasswordKey : SyedAbsarObjectBase {
    
    
    /// User ID
    var cpUserID: String?
    
    /// User Password
    var cpUserPassword: String?
    
    /// App Key
    var cpAppKey: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UserID","UserPassword","AppKey"]
    }
}

/**
 Login By User Password Key Output.
 */
@objc(LoginByUserPasswordKeyOutput)
open class LoginByUserPasswordKeyOutput : SyedAbsarObjectBase {
    
    
    /// User Code
    var cpUserCode: Int = 0
    
    /// Ws Key
    var cpWsKey: String?
    
    /// User Nickname
    var cpUserNickname: String?
    
    /// User I D
    var cpUserID: String?
    
    /// User Surname1
    var cpUserSurname1: String?
    
    /// User Surname2
    var cpUserSurname2: String?
    
    /// User Firstname
    var cpUserFirstname: String?
    
    /// User Photo
    var cpUserPhoto: String?
    
    /// User Birthday
    var cpUserBirthday: String?
    
    /// User Role
    var cpUserRole: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["UserCode","WsKey","UserNickname","UserID","UserSurname1","UserSurname2","UserFirstname","UserPhoto","UserBirthday","UserRole"]
    }
}

/**
 Login By Session Key.
 */
@objc(LoginBySessionKey)
open class LoginBySessionKey : SyedAbsarObjectBase {
    
    
    /// Session I D
    var cpSessionID: String?
    
    /// App Key
    var cpAppKey: String?
    
    override static func cpKeys() -> Array<String> {
        return ["SessionID","AppKey"]
    }
}

/**
 Login By Session Key Output.
 */
@objc(LoginBySessionKeyOutput)
open class LoginBySessionKeyOutput : SyedAbsarObjectBase {
    
    
    /// User Code
    var cpUserCode: Int = 0
    
    /// Degree Type Code
    var cpDegreeTypeCode: Int = 0
    
    /// Degree Code
    var cpDegreeCode: Int = 0
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Ws Key
    var cpWsKey: String?
    
    /// User Nickname
    var cpUserNickname: String?
    
    /// User I D
    var cpUserID: String?
    
    /// User Surname1
    var cpUserSurname1: String?
    
    /// User Surname2
    var cpUserSurname2: String?
    
    /// User Firstname
    var cpUserFirstname: String?
    
    /// User Photo
    var cpUserPhoto: String?
    
    /// User Birthday
    var cpUserBirthday: String?
    
    /// User Role
    var cpUserRole: Int = 0
    
    /// Degree Type Name
    var cpDegreeTypeName: String?
    
    /// Degree Name
    var cpDegreeName: String?
    
    /// Course Name
    var cpCourseName: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UserCode","DegreeTypeCode","DegreeCode","CourseCode","WsKey","UserNickname","UserID","UserSurname1","UserSurname2","UserFirstname","UserPhoto","UserBirthday","UserRole","DegreeTypeName","DegreeName","CourseName"]
    }
}

/**
 Get New Password.
 */
@objc(GetNewPassword)
open class GetNewPassword : SyedAbsarObjectBase {
    
    
    /// User I D
    var cpUserID: String?
    
    /// App Key
    var cpAppKey: String?
    
    override static func cpKeys() -> Array<String> {
        return ["UserID","AppKey"]
    }
}

/**
 Get New Password Output.
 */
@objc(GetNewPasswordOutput)
open class GetNewPasswordOutput : SyedAbsarObjectBase {
    
    
    /// Success
    var cpSuccess: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["Success"]
    }
}

/**
 Get Courses.
 */
@objc(GetCourses)
open class GetCourses : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey"]
    }
}

/**
 Get Courses Output.
 */
@objc(GetCoursesOutput)
open class GetCoursesOutput : SyedAbsarObjectBase {
    
    
    /// Num Courses
    var cpNumCourses: Int = 0
    
    /// Courses Array
    var cpCoursesArray: CoursesArray?
    
    override static func cpKeys() -> Array<String> {
        return ["NumCourses","CoursesArray"]
    }
}

/**
 Get Course Info.
 */
@objc(GetCourseInfo)
open class GetCourseInfo : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Info Type
    var cpInfoType: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","InfoType"]
    }
}

/**
 Get Course Info Output.
 */
@objc(GetCourseInfoOutput)
open class GetCourseInfoOutput : SyedAbsarObjectBase {
    
    
    /// Info Src
    var cpInfoSrc: String?
    
    /// Info Txt
    var cpInfoTxt: String?
    
    override static func cpKeys() -> Array<String> {
        return ["InfoSrc","InfoTxt"]
    }
}

/**
 Get Group Types.
 */
@objc(GetGroupTypes)
open class GetGroupTypes : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode"]
    }
}

/**
 Get Group Types Output.
 */
@objc(GetGroupTypesOutput)
open class GetGroupTypesOutput : SyedAbsarObjectBase {
    
    
    /// Num Group Types
    var cpNumGroupTypes: Int = 0
    
    /// Group Types Array
    var cpGroupTypesArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumGroupTypes","GroupTypesArray"]
    }
}

/**
 Get Groups.
 */
@objc(GetGroups)
open class GetGroups : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode"]
    }
}

/**
 Get Groups Output.
 */
@objc(GetGroupsOutput)
open class GetGroupsOutput : SyedAbsarObjectBase {
    
    
    /// Num Groups
    var cpNumGroups: Int = 0
    
    /// Groups Array
    var cpGroupsArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumGroups","GroupsArray"]
    }
}

/**
 Send My Groups.
 */
@objc(SendMyGroups)
open class SendMyGroups : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// My Groups
    var cpMyGroups: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","MyGroups"]
    }
}

/**
 Send My Groups Output.
 */
@objc(SendMyGroupsOutput)
open class SendMyGroupsOutput : SyedAbsarObjectBase {
    
    
    /// Success
    var cpSuccess: Int = 0
    
    /// Num Groups
    var cpNumGroups: Int = 0
    
    /// Groups Array
    var cpGroupsArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Success","NumGroups","GroupsArray"]
    }
}

/**
 Get Directory Tree.
 */
@objc(GetDirectoryTree)
open class GetDirectoryTree : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Group Code
    var cpGroupCode: Int = 0
    
    /// Tree Code
    var cpTreeCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","GroupCode","TreeCode"]
    }
}

/**
 Get Directory Tree Output.
 */
@objc(GetDirectoryTreeOutput)
open class GetDirectoryTreeOutput : SyedAbsarObjectBase {
    
    
    /// Tree
    var cpTree: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Tree"]
    }
}

/**
 Get File.
 */
@objc(GetFile)
open class GetFile : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// File Code
    var cpFileCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","FileCode"]
    }
}

/**
 Get File Output.
 */
@objc(GetFileOutput)
open class GetFileOutput : SyedAbsarObjectBase {
    
    
    /// File Name
    var cpFileName: String?
    
    /// U R L
    var cpURL: String?
    
    /// Size
    var cpSize: Int = 0
    
    /// Time
    var cpTime: Int = 0
    
    /// License
    var cpLicense: String?
    
    /// Publisher Name
    var cpPublisherName: String?
    
    /// Publisher Photo
    var cpPublisherPhoto: String?
    
    override static func cpKeys() -> Array<String> {
        return ["FileName","URL","Size","Time","License","PublisherName","PublisherPhoto"]
    }
}

/**
 Get Marks.
 */
@objc(GetMarks)
open class GetMarks : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// File Code
    var cpFileCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","FileCode"]
    }
}

/**
 Get Marks Output.
 */
@objc(GetMarksOutput)
open class GetMarksOutput : SyedAbsarObjectBase {
    
    
    /// Content
    var cpContent: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Content"]
    }
}

/**
 Get Test Config.
 */
@objc(GetTestConfig)
open class GetTestConfig : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode"]
    }
}

/**
 Get Test Config Output.
 */
@objc(GetTestConfigOutput)
open class GetTestConfigOutput : SyedAbsarObjectBase {
    
    
    /// Pluggable
    var cpPluggable: Int = 0
    
    /// Num Questions
    var cpNumQuestions: Int = 0
    
    /// Min Questions
    var cpMinQuestions: Int = 0
    
    /// Def Questions
    var cpDefQuestions: Int = 0
    
    /// Max Questions
    var cpMaxQuestions: Int = 0
    
    /// Feedback
    var cpFeedback: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Pluggable","NumQuestions","MinQuestions","DefQuestions","MaxQuestions","Feedback"]
    }
}

/**
 Get Tests.
 */
@objc(GetTests)
open class GetTests : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Begin Time
    var cpBeginTime: CLong?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","BeginTime"]
    }
}

/**
 Get Tests Output.
 */
@objc(GetTestsOutput)
open class GetTestsOutput : SyedAbsarObjectBase {
    
    
    /// Tags Array
    var cpTagsArray: String?
    
    /// Questions Array
    var cpQuestionsArray: String?
    
    /// Answers Array
    var cpAnswersArray: String?
    
    /// Question Tags Array
    var cpQuestionTagsArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["TagsArray","QuestionsArray","AnswersArray","QuestionTagsArray"]
    }
}

/**
 Get Trivial Question.
 */
@objc(GetTrivialQuestion)
open class GetTrivialQuestion : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Degrees
    var cpDegrees: String?
    
    /// Lower Score
    var cpLowerScore: Float?
    
    /// Upper Score
    var cpUpperScore: Float?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","Degrees","LowerScore","UpperScore"]
    }
}

/**
 Get Trivial Question Output.
 */
@objc(GetTrivialQuestionOutput)
open class GetTrivialQuestionOutput : SyedAbsarObjectBase {
    
    
    /// Question
    var cpQuestion: String?
    
    /// Answers Array
    var cpAnswersArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["Question","AnswersArray"]
    }
}

/**
 Get Users.
 */
@objc(GetUsers)
open class GetUsers : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Group Code
    var cpGroupCode: Int = 0
    
    /// User Role
    var cpUserRole: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","GroupCode","UserRole"]
    }
}

/**
 Get Users Output.
 */
@objc(GetUsersOutput)
open class GetUsersOutput : SyedAbsarObjectBase {
    
    
    /// Num Users
    var cpNumUsers: Int = 0
    
    /// Users Array
    var cpUsersArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumUsers","UsersArray"]
    }
}

/**
 Get Attendance Events.
 */
@objc(GetAttendanceEvents)
open class GetAttendanceEvents : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode"]
    }
}

/**
 Get Attendance Events Output.
 */
@objc(GetAttendanceEventsOutput)
open class GetAttendanceEventsOutput : SyedAbsarObjectBase {
    
    
    /// Num Events
    var cpNumEvents: Int = 0
    
    /// Events Array
    var cpEventsArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumEvents","EventsArray"]
    }
}

/**
 Send Attendance Event.
 */
@objc(SendAttendanceEvent)
open class SendAttendanceEvent : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Attendance Event Code
    var cpAttendanceEventCode: Int = 0
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Hidden
    var cpHidden: Int = 0
    
    /// Start Time
    var cpStartTime: Int = 0
    
    /// End Time
    var cpEndTime: Int = 0
    
    /// Comments Teachers Visible
    var cpCommentsTeachersVisible: Int = 0
    
    /// Title
    var cpTitle: String?
    
    /// Text
    var cpText: String?
    
    /// Groups
    var cpGroups: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","AttendanceEventCode","CourseCode","Hidden","StartTime","EndTime","CommentsTeachersVisible","Title","Text","Groups"]
    }
}

/**
 Send Attendance Event Output.
 */
@objc(SendAttendanceEventOutput)
open class SendAttendanceEventOutput : SyedAbsarObjectBase {
    
    
    /// Attendance Event Code
    var cpAttendanceEventCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["AttendanceEventCode"]
    }
}

/**
 Get Attendance Users.
 */
@objc(GetAttendanceUsers)
open class GetAttendanceUsers : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Attendance Event Code
    var cpAttendanceEventCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","AttendanceEventCode"]
    }
}

/**
 Get Attendance Users Output.
 */
@objc(GetAttendanceUsersOutput)
open class GetAttendanceUsersOutput : SyedAbsarObjectBase {
    
    
    /// Num Users
    var cpNumUsers: Int = 0
    
    /// Users Array
    var cpUsersArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumUsers","UsersArray"]
    }
}

/**
 Send Attendance Users.
 */
@objc(SendAttendanceUsers)
open class SendAttendanceUsers : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Attendance Event Code
    var cpAttendanceEventCode: Int = 0
    
    /// Users
    var cpUsers: String?
    
    /// Set Others As Absent
    var cpSetOthersAsAbsent: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","AttendanceEventCode","Users","SetOthersAsAbsent"]
    }
}

/**
 Send Attendance Users Output.
 */
@objc(SendAttendanceUsersOutput)
open class SendAttendanceUsersOutput : SyedAbsarObjectBase {
    
    
    /// Success
    var cpSuccess: Int = 0
    
    /// Num Users
    var cpNumUsers: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["Success","NumUsers"]
    }
}

/**
 Get Notifications.
 */
@objc(GetNotifications)
open class GetNotifications : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Begin Time
    var cpBeginTime: CLong?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","BeginTime"]
    }
}

/**
 Get Notifications Output.
 */
@objc(GetNotificationsOutput)
open class GetNotificationsOutput : SyedAbsarObjectBase {
    
    
    /// Num Notifications
    var cpNumNotifications: Int = 0
    
    /// Notifications Array
    var cpNotificationsArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumNotifications","NotificationsArray"]
    }
}

/**
 Mark Notifications As Read.
 */
@objc(MarkNotificationsAsRead)
open class MarkNotificationsAsRead : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Notifications
    var cpNotifications: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","Notifications"]
    }
}

/**
 Mark Notifications As Read Output.
 */
@objc(MarkNotificationsAsReadOutput)
open class MarkNotificationsAsReadOutput : SyedAbsarObjectBase {
    
    
    /// Num Notifications
    var cpNumNotifications: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["NumNotifications"]
    }
}

/**
 Send Notice.
 */
@objc(SendNotice)
open class SendNotice : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Course Code
    var cpCourseCode: Int = 0
    
    /// Body
    var cpBody: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","CourseCode","Body"]
    }
}

/**
 Send Notice Output.
 */
@objc(SendNoticeOutput)
open class SendNoticeOutput : SyedAbsarObjectBase {
    
    
    /// Notice Code
    var cpNoticeCode: Int = 0
    
    override static func cpKeys() -> Array<String> {
        return ["NoticeCode"]
    }
}

/**
 Send Message.
 */
@objc(SendMessage)
open class SendMessage : SyedAbsarObjectBase {
    
    
    /// Ws Key
    var cpWsKey: String?
    
    /// Message Code
    var cpMessageCode: String?
    
    /// To
    var cpTo: String?
    
    /// Subject
    var cpSubject: String?
    
    /// Body
    var cpBody: String?
    
    override static func cpKeys() -> Array<String> {
        return ["WsKey","MessageCode","To","Subject","Body"]
    }
}

/**
 Send Message Output.
 */
@objc(SendMessageOutput)
open class SendMessageOutput : SyedAbsarObjectBase {
    
    
    /// Num Users
    var cpNumUsers: Int = 0
    
    /// Users Array
    var cpUsersArray: String?
    
    override static func cpKeys() -> Array<String> {
        return ["NumUsers","UsersArray"]
    }
}


/**
 A generic base class for all Objects.
 */
open class SyedAbsarObjectBase : NSObject
{
    var xmlResponseString: String?
    
    class func cpKeys() -> Array <String>
    {
        return []
    }
    
    required override public init(){}
    
    class func newInstance() -> Self {
        return self.init()
    }
    
    
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: r.lowerBound)
        let end = self.index(start, offsetBy: r.upperBound - r.lowerBound)
        return String(self[start ..< end])
    }
}

