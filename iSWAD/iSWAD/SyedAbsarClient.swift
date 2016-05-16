 
/* 
Copyright (c) 2016 Syed Absar Karim https://www.linkedin.com/in/syedabsar

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
 
import Foundation

/* Soap Client Generated from WSDL: https://swad.ugr.es/ws/swad.wsdl powered by http://www.wsdl2swift.com */

public class SyedAbsarClient {

/**
    Calls the SOAP Operation: CreateAccount with Message based on CreateAccount Object.

    - parameter createAccount:  CreateAccount Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opCreateAccount(createAccount : CreateAccount , completionHandler: (CreateAccountOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:createAccount><userNickname>%@</userNickname><userEmail>%@</userEmail><userPassword>%@</userPassword><appKey>%@</appKey></ns1:createAccount></SOAP-ENV:Body></SOAP-ENV:Envelope>",createAccount.cpUserNickname!,createAccount.cpUserEmail!,createAccount.cpUserPassword!,createAccount.cpAppKey!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"CreateAccountOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? CreateAccountOutput,error) })
 }

/**
    Calls the SOAP Operation: LoginByUserPasswordKey with Message based on LoginByUserPasswordKey Object.

    - parameter loginByUserPasswordKey:  LoginByUserPasswordKey Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opLoginByUserPasswordKey(loginByUserPasswordKey : LoginByUserPasswordKey , completionHandler: (LoginByUserPasswordKeyOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:loginByUserPasswordKey><userID>%@</userID><userPassword>%@</userPassword><appKey>%@</appKey></ns1:loginByUserPasswordKey></SOAP-ENV:Body></SOAP-ENV:Envelope>",loginByUserPasswordKey.cpUserID!,loginByUserPasswordKey.cpUserPassword!,loginByUserPasswordKey.cpAppKey!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"LoginByUserPasswordKeyOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? LoginByUserPasswordKeyOutput,error) })
 }

/**
    Calls the SOAP Operation: LoginBySessionKey with Message based on LoginBySessionKey Object.

    - parameter loginBySessionKey:  LoginBySessionKey Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opLoginBySessionKey(loginBySessionKey : LoginBySessionKey , completionHandler: (LoginBySessionKeyOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:loginBySessionKey><sessionID>%@</sessionID><appKey>%@</appKey></ns1:loginBySessionKey></SOAP-ENV:Body></SOAP-ENV:Envelope>",loginBySessionKey.cpSessionID!,loginBySessionKey.cpAppKey!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"LoginBySessionKeyOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? LoginBySessionKeyOutput,error) })
 }

/**
    Calls the SOAP Operation: GetNewPassword with Message based on GetNewPassword Object.

    - parameter getNewPassword:  GetNewPassword Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetNewPassword(getNewPassword : GetNewPassword , completionHandler: (GetNewPasswordOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getNewPassword><userID>%@</userID><appKey>%@</appKey></ns1:getNewPassword></SOAP-ENV:Body></SOAP-ENV:Envelope>",getNewPassword.cpUserID!,getNewPassword.cpAppKey!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetNewPasswordOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetNewPasswordOutput,error) })
 }

/**
    Calls the SOAP Operation: GetCourses with Message based on GetCourses Object.

    - parameter getCourses:  GetCourses Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetCourses(getCourses : GetCourses , completionHandler: (GetCoursesOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getCourses><wsKey>%@</wsKey></ns1:getCourses></SOAP-ENV:Body></SOAP-ENV:Envelope>",getCourses.cpWsKey!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetCoursesOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetCoursesOutput,error) })
 }

/**
    Calls the SOAP Operation: GetCourseInfo with Message based on GetCourseInfo Object.

    - parameter getCourseInfo:  GetCourseInfo Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetCourseInfo(getCourseInfo : GetCourseInfo , completionHandler: (GetCourseInfoOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getCourseInfo><wsKey>%@</wsKey><courseCode>0</courseCode><infoType>%@</infoType></ns1:getCourseInfo></SOAP-ENV:Body></SOAP-ENV:Envelope>",getCourseInfo.cpWsKey!,getCourseInfo.cpCourseCode!,getCourseInfo.cpInfoType!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetCourseInfoOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetCourseInfoOutput,error) })
 }

/**
    Calls the SOAP Operation: GetGroupTypes with Message based on GetGroupTypes Object.

    - parameter getGroupTypes:  GetGroupTypes Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetGroupTypes(getGroupTypes : GetGroupTypes , completionHandler: (GetGroupTypesOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getGroupTypes><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getGroupTypes></SOAP-ENV:Body></SOAP-ENV:Envelope>",getGroupTypes.cpWsKey!,getGroupTypes.cpCourseCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetGroupTypesOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetGroupTypesOutput,error) })
 }

/**
    Calls the SOAP Operation: GetGroups with Message based on GetGroups Object.

    - parameter getGroups:  GetGroups Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetGroups(getGroups : GetGroups , completionHandler: (GetGroupsOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getGroups><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getGroups></SOAP-ENV:Body></SOAP-ENV:Envelope>",getGroups.cpWsKey!,getGroups.cpCourseCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetGroupsOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetGroupsOutput,error) })
 }

/**
    Calls the SOAP Operation: SendMyGroups with Message based on SendMyGroups Object.

    - parameter sendMyGroups:  SendMyGroups Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opSendMyGroups(sendMyGroups : SendMyGroups , completionHandler: (SendMyGroupsOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendMyGroups><wsKey>%@</wsKey><courseCode>0</courseCode><myGroups>%@</myGroups></ns1:sendMyGroups></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendMyGroups.cpWsKey!,sendMyGroups.cpCourseCode!,sendMyGroups.cpMyGroups!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendMyGroupsOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? SendMyGroupsOutput,error) })
 }

/**
    Calls the SOAP Operation: GetDirectoryTree with Message based on GetDirectoryTree Object.

    - parameter getDirectoryTree:  GetDirectoryTree Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetDirectoryTree(getDirectoryTree : GetDirectoryTree , completionHandler: (GetDirectoryTreeOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getDirectoryTree><wsKey>%@</wsKey><courseCode>0</courseCode><groupCode>0</groupCode><treeCode>0</treeCode></ns1:getDirectoryTree></SOAP-ENV:Body></SOAP-ENV:Envelope>",getDirectoryTree.cpWsKey!,getDirectoryTree.cpCourseCode!,getDirectoryTree.cpGroupCode!,getDirectoryTree.cpTreeCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetDirectoryTreeOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetDirectoryTreeOutput,error) })
 }

/**
    Calls the SOAP Operation: GetFile with Message based on GetFile Object.

    - parameter getFile:  GetFile Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetFile(getFile : GetFile , completionHandler: (GetFileOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getFile><wsKey>%@</wsKey><fileCode>0</fileCode></ns1:getFile></SOAP-ENV:Body></SOAP-ENV:Envelope>",getFile.cpWsKey!,getFile.cpFileCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetFileOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetFileOutput,error) })
 }

/**
    Calls the SOAP Operation: GetMarks with Message based on GetMarks Object.

    - parameter getMarks:  GetMarks Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetMarks(getMarks : GetMarks , completionHandler: (GetMarksOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getMarks><wsKey>%@</wsKey><fileCode>0</fileCode></ns1:getMarks></SOAP-ENV:Body></SOAP-ENV:Envelope>",getMarks.cpWsKey!,getMarks.cpFileCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetMarksOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetMarksOutput,error) })
 }

/**
    Calls the SOAP Operation: GetTestConfig with Message based on GetTestConfig Object.

    - parameter getTestConfig:  GetTestConfig Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetTestConfig(getTestConfig : GetTestConfig , completionHandler: (GetTestConfigOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getTestConfig><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getTestConfig></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTestConfig.cpWsKey!,getTestConfig.cpCourseCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetTestConfigOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetTestConfigOutput,error) })
 }

/**
    Calls the SOAP Operation: GetTests with Message based on GetTests Object.

    - parameter getTests:  GetTests Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetTests(getTests : GetTests , completionHandler: (GetTestsOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getTests><wsKey>%@</wsKey><courseCode>0</courseCode><beginTime>0</beginTime></ns1:getTests></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTests.cpWsKey!,getTests.cpCourseCode!,getTests.cpBeginTime!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetTestsOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetTestsOutput,error) })
 }

/**
    Calls the SOAP Operation: GetTrivialQuestion with Message based on GetTrivialQuestion Object.

    - parameter getTrivialQuestion:  GetTrivialQuestion Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetTrivialQuestion(getTrivialQuestion : GetTrivialQuestion , completionHandler: (GetTrivialQuestionOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getTrivialQuestion><wsKey>%@</wsKey><degrees>%@</degrees><lowerScore>0</lowerScore><upperScore>0</upperScore></ns1:getTrivialQuestion></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTrivialQuestion.cpWsKey!,getTrivialQuestion.cpDegrees!,getTrivialQuestion.cpLowerScore!,getTrivialQuestion.cpUpperScore!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetTrivialQuestionOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetTrivialQuestionOutput,error) })
 }

/**
    Calls the SOAP Operation: GetUsers with Message based on GetUsers Object.

    - parameter getUsers:  GetUsers Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetUsers(getUsers : GetUsers , completionHandler: (GetUsersOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getUsers><wsKey>%@</wsKey><courseCode>0</courseCode><groupCode>0</groupCode><userRole>0</userRole></ns1:getUsers></SOAP-ENV:Body></SOAP-ENV:Envelope>",getUsers.cpWsKey!,getUsers.cpCourseCode!,getUsers.cpGroupCode!,getUsers.cpUserRole!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetUsersOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetUsersOutput,error) })
 }

/**
    Calls the SOAP Operation: GetAttendanceEvents with Message based on GetAttendanceEvents Object.

    - parameter getAttendanceEvents:  GetAttendanceEvents Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetAttendanceEvents(getAttendanceEvents : GetAttendanceEvents , completionHandler: (GetAttendanceEventsOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getAttendanceEvents><wsKey>%@</wsKey><courseCode>0</courseCode></ns1:getAttendanceEvents></SOAP-ENV:Body></SOAP-ENV:Envelope>",getAttendanceEvents.cpWsKey!,getAttendanceEvents.cpCourseCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetAttendanceEventsOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetAttendanceEventsOutput,error) })
 }

/**
    Calls the SOAP Operation: SendAttendanceEvent with Message based on SendAttendanceEvent Object.

    - parameter sendAttendanceEvent:  SendAttendanceEvent Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opSendAttendanceEvent(sendAttendanceEvent : SendAttendanceEvent , completionHandler: (SendAttendanceEventOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendAttendanceEvent><wsKey>%@</wsKey><attendanceEventCode>0</attendanceEventCode><courseCode>0</courseCode><hidden>0</hidden><startTime>0</startTime><endTime>0</endTime><commentsTeachersVisible>0</commentsTeachersVisible><title>%@</title><text>%@</text><groups>%@</groups></ns1:sendAttendanceEvent></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendAttendanceEvent.cpWsKey!,sendAttendanceEvent.cpAttendanceEventCode!,sendAttendanceEvent.cpCourseCode!,sendAttendanceEvent.cpHidden!,sendAttendanceEvent.cpStartTime!,sendAttendanceEvent.cpEndTime!,sendAttendanceEvent.cpCommentsTeachersVisible!,sendAttendanceEvent.cpTitle!,sendAttendanceEvent.cpText!,sendAttendanceEvent.cpGroups!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendAttendanceEventOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? SendAttendanceEventOutput,error) })
 }

/**
    Calls the SOAP Operation: GetAttendanceUsers with Message based on GetAttendanceUsers Object.

    - parameter getAttendanceUsers:  GetAttendanceUsers Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetAttendanceUsers(getAttendanceUsers : GetAttendanceUsers , completionHandler: (GetAttendanceUsersOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getAttendanceUsers><wsKey>%@</wsKey><attendanceEventCode>0</attendanceEventCode></ns1:getAttendanceUsers></SOAP-ENV:Body></SOAP-ENV:Envelope>",getAttendanceUsers.cpWsKey!,getAttendanceUsers.cpAttendanceEventCode!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetAttendanceUsersOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetAttendanceUsersOutput,error) })
 }

/**
    Calls the SOAP Operation: SendAttendanceUsers with Message based on SendAttendanceUsers Object.

    - parameter sendAttendanceUsers:  SendAttendanceUsers Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opSendAttendanceUsers(sendAttendanceUsers : SendAttendanceUsers , completionHandler: (SendAttendanceUsersOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendAttendanceUsers><wsKey>%@</wsKey><attendanceEventCode>0</attendanceEventCode><users>%@</users><setOthersAsAbsent>0</setOthersAsAbsent></ns1:sendAttendanceUsers></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendAttendanceUsers.cpWsKey!,sendAttendanceUsers.cpAttendanceEventCode!,sendAttendanceUsers.cpUsers!,sendAttendanceUsers.cpSetOthersAsAbsent!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendAttendanceUsersOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? SendAttendanceUsersOutput,error) })
 }

/**
    Calls the SOAP Operation: GetNotifications with Message based on GetNotifications Object.

    - parameter getNotifications:  GetNotifications Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetNotifications(getNotifications : GetNotifications , completionHandler: (GetNotificationsOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:getNotifications><wsKey>%@</wsKey><beginTime>0</beginTime></ns1:getNotifications></SOAP-ENV:Body></SOAP-ENV:Envelope>",getNotifications.cpWsKey!,getNotifications.cpBeginTime!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"GetNotificationsOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetNotificationsOutput,error) })
 }

/**
    Calls the SOAP Operation: MarkNotificationsAsRead with Message based on MarkNotificationsAsRead Object.

    - parameter markNotificationsAsRead:  MarkNotificationsAsRead Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opMarkNotificationsAsRead(markNotificationsAsRead : MarkNotificationsAsRead , completionHandler: (MarkNotificationsAsReadOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:markNotificationsAsRead><wsKey>%@</wsKey><notifications>%@</notifications></ns1:markNotificationsAsRead></SOAP-ENV:Body></SOAP-ENV:Envelope>",markNotificationsAsRead.cpWsKey!,markNotificationsAsRead.cpNotifications!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"MarkNotificationsAsReadOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? MarkNotificationsAsReadOutput,error) })
 }

/**
    Calls the SOAP Operation: SendNotice with Message based on SendNotice Object.

    - parameter sendNotice:  SendNotice Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opSendNotice(sendNotice : SendNotice , completionHandler: (SendNoticeOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendNotice><wsKey>%@</wsKey><courseCode>0</courseCode><body>%@</body></ns1:sendNotice></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendNotice.cpWsKey!,sendNotice.cpCourseCode!,sendNotice.cpBody!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendNoticeOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? SendNoticeOutput,error) })
 }

/**
    Calls the SOAP Operation: SendMessage with Message based on SendMessage Object.

    - parameter sendMessage:  SendMessage Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opSendMessage(sendMessage : SendMessage , completionHandler: (SendMessageOutput?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"urn:swad\"><SOAP-ENV:Body><ns1:sendMessage><wsKey>%@</wsKey><messageCode>0</messageCode><to>%@</to><subject>%@</subject><body>%@</body></ns1:sendMessage></SOAP-ENV:Body></SOAP-ENV:Envelope>",sendMessage.cpWsKey!,sendMessage.cpMessageCode!,sendMessage.cpTo!,sendMessage.cpSubject!,sendMessage.cpBody!)

self.makeSoapConnection("https://swad.ugr.es/", soapAction: "", soapMessage: soapMessage, soapVersion: "1", className:"SendMessageOutput", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? SendMessageOutput,error) })
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
private func makeSoapConnection(soapLocation: String, soapAction: String, soapMessage: String,  soapVersion: String, className: String, completionHandler: (SyedAbsarObjectBase?, NSError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: soapLocation)!)
        let msgLength  = String(soapMessage.characters.count)
        let data = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        request.HTTPMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        // request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        request.HTTPBody = data
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let datastring = NSString(data: data!, encoding:NSUTF8StringEncoding) as! String
            print(datastring)
            
            //This is a temporary code where it returns the actual XML Response
            //At the moment, response parsing and mapping is under progress
            let aClass = NSClassFromString(className) as! SyedAbsarObjectBase.Type
            let currentResp = aClass.newInstance()
            currentResp.xmlResponseString = "\(datastring)"
            completionHandler(currentResp, error)
            return

			//TODO: Code in progress for response parsing and mapping
			/*
            let xml = SWXMLHash.parse(datastring)
            
            let  coreElementKey = className
            
            let aClass = NSClassFromString(className) as! SyedAbsarObjectBase.Type
            
            let obj = aClass
            
            let inst = obj.newInstance()
            
			var error : NSError?
            let soapFault = xml["soap:Envelope"]["soap:Body"]["soap:Fault"]
            
            if soapFault {
            
                let val =  soapFault["faultstring"].element?.text
                
                error =  NSError(domain: "soapFault", code: 0, userInfo: NSDictionary(object: val!, forKey: NSLocalizedDescriptionKey) as [NSObject : AnyObject])
            }
            
            if (error == nil) {
                for key in obj.cpKeys()  {
                    
                    let body =  xml["soap:Envelope"]["soap:Body"]
                    let val =  body[coreElementKey][key].element?.text
                    
                    inst.setValue(val, forKeyPath: "cp"+key)
                    
                    print (inst)
                }
            }
            completionHandler(inst, error)
            */

        }
        task.resume()

    }    




}
/** 
  Course. 
*/
@objc(Course)
public class Course : SyedAbsarObjectBase {


/// Course Code
var cpCourseCode: Int?

/// Course Short Name
var cpCourseShortName: String?

/// Course Full Name
var cpCourseFullName: String?

/// User Role
var cpUserRole: Int?

override static func cpKeys() -> Array<String> {
return ["CourseCode","CourseShortName","CourseFullName","UserRole"]
}
}

/** 
  Courses Array. 
*/
@objc(CoursesArray)
public class CoursesArray : SyedAbsarObjectBase {


/// Item
var cpItem: String?

override static func cpKeys() -> Array<String> {
return ["Item"]
}
}

/** 
  Group Type. 
*/
@objc(GroupType)
public class GroupType : SyedAbsarObjectBase {


/// Group Type Code
var cpGroupTypeCode: Int?

/// Group Type Name
var cpGroupTypeName: String?

/// Mandatory
var cpMandatory: Int?

/// Multiple
var cpMultiple: Int?

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
public class GroupTypesArray : SyedAbsarObjectBase {


/// Item
var cpItem: String?

override static func cpKeys() -> Array<String> {
return ["Item"]
}
}

/** 
  Group. 
*/
@objc(Group)
public class Group : SyedAbsarObjectBase {


/// Group Code
var cpGroupCode: Int?

/// Group Name
var cpGroupName: String?

/// Group Type Code
var cpGroupTypeCode: Int?

/// Group Type Name
var cpGroupTypeName: String?

/// Open
var cpOpen: Int?

/// Max Students
var cpMaxStudents: Int?

/// Num Students
var cpNumStudents: Int?

/// File Zones
var cpFileZones: Int?

/// Member
var cpMember: Int?

override static func cpKeys() -> Array<String> {
return ["GroupCode","GroupName","GroupTypeCode","GroupTypeName","Open","MaxStudents","NumStudents","FileZones","Member"]
}
}

/** 
  Groups Array. 
*/
@objc(GroupsArray)
public class GroupsArray : SyedAbsarObjectBase {


/// Item
var cpItem: String?

override static func cpKeys() -> Array<String> {
return ["Item"]
}
}

/** 
  Notification. 
*/
@objc(Notification)
public class Notification : SyedAbsarObjectBase {


/// Notif Code
var cpNotifCode: Int?

/// Event Type
var cpEventType: String?

/// Event Code
var cpEventCode: Int?

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
var cpStatus: Int?

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
public class NotificationsArray : SyedAbsarObjectBase {


/// Item
var cpItem: String?

override static func cpKeys() -> Array<String> {
return ["Item"]
}
}

/** 
  Tag. 
*/
@objc(Tag)
public class Tag : SyedAbsarObjectBase {


/// Tag Code
var cpTagCode: Int?

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
public class TagsArray : SyedAbsarObjectBase {


/// Item
var cpItem: String?

override static func cpKeys() -> Array<String> {
return ["Item"]
}
}

/** 
  Question. 
*/
@objc(Question)
public class Question : SyedAbsarObjectBase {


/// Question Code
var cpQuestionCode: Int?

/// Answer Type
var cpAnswerType: String?

/// Shuffle
var cpShuffle: Int?

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
public class QuestionsArray : SyedAbsarObjectBase {


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
public class Answer : SyedAbsarObjectBase {


/// Question Code
var cpQuestionCode: Int?

/// Answer Index
var cpAnswerIndex: Int?

/// Correct
var cpCorrect: Int?

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
public class AnswersArray : SyedAbsarObjectBase {


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
public class QuestionTag : SyedAbsarObjectBase {


/// Question Code
var cpQuestionCode: Int?

/// Tag Code
var cpTagCode: Int?

/// Tag Index
var cpTagIndex: Int?

override static func cpKeys() -> Array<String> {
return ["QuestionCode","TagCode","TagIndex"]
}
}

/** 
  Question Tags Array. 
*/
@objc(QuestionTagsArray)
public class QuestionTagsArray : SyedAbsarObjectBase {


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
public class User : SyedAbsarObjectBase {


/// User Code
var cpUserCode: Int?

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
public class UsersArray : SyedAbsarObjectBase {


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
public class AttendanceEvent : SyedAbsarObjectBase {


/// Attendance Event Code
var cpAttendanceEventCode: Int?

/// Hidden
var cpHidden: Int?

/// User Surname1
var cpUserSurname1: String?

/// User Surname2
var cpUserSurname2: String?

/// User Firstname
var cpUserFirstname: String?

/// User Photo
var cpUserPhoto: String?

/// Start Time
var cpStartTime: Int?

/// End Time
var cpEndTime: Int?

/// Comments Teachers Visible
var cpCommentsTeachersVisible: Int?

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
public class AttendanceEventsArray : SyedAbsarObjectBase {


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
public class AttendanceUser : SyedAbsarObjectBase {


/// User Code
var cpUserCode: Int?

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
var cpPresent: Int?

override static func cpKeys() -> Array<String> {
return ["UserCode","UserNickname","UserID","UserSurname1","UserSurname2","UserFirstname","UserPhoto","Present"]
}
}

/** 
  Attendance Users Array. 
*/
@objc(AttendanceUsersArray)
public class AttendanceUsersArray : SyedAbsarObjectBase {


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
public class CreateAccount : SyedAbsarObjectBase {


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
public class CreateAccountOutput : SyedAbsarObjectBase {


/// User Code
var cpUserCode: Int?

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
public class LoginByUserPasswordKey : SyedAbsarObjectBase {


/// User I D
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
public class LoginByUserPasswordKeyOutput : SyedAbsarObjectBase {


/// User Code
var cpUserCode: Int?

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
var cpUserRole: Int?

override static func cpKeys() -> Array<String> {
return ["UserCode","WsKey","UserNickname","UserID","UserSurname1","UserSurname2","UserFirstname","UserPhoto","UserBirthday","UserRole"]
}
}

/** 
  Login By Session Key. 
*/
@objc(LoginBySessionKey)
public class LoginBySessionKey : SyedAbsarObjectBase {


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
public class LoginBySessionKeyOutput : SyedAbsarObjectBase {


/// User Code
var cpUserCode: Int?

/// Degree Type Code
var cpDegreeTypeCode: Int?

/// Degree Code
var cpDegreeCode: Int?

/// Course Code
var cpCourseCode: Int?

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
var cpUserRole: Int?

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
public class GetNewPassword : SyedAbsarObjectBase {


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
public class GetNewPasswordOutput : SyedAbsarObjectBase {


/// Success
var cpSuccess: Int?

override static func cpKeys() -> Array<String> {
return ["Success"]
}
}

/** 
  Get Courses. 
*/
@objc(GetCourses)
public class GetCourses : SyedAbsarObjectBase {


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
public class GetCoursesOutput : SyedAbsarObjectBase {


/// Num Courses
var cpNumCourses: Int?

/// Courses Array
var cpCoursesArray: String?

override static func cpKeys() -> Array<String> {
return ["NumCourses","CoursesArray"]
}
}

/** 
  Get Course Info. 
*/
@objc(GetCourseInfo)
public class GetCourseInfo : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

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
public class GetCourseInfoOutput : SyedAbsarObjectBase {


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
public class GetGroupTypes : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","CourseCode"]
}
}

/** 
  Get Group Types Output. 
*/
@objc(GetGroupTypesOutput)
public class GetGroupTypesOutput : SyedAbsarObjectBase {


/// Num Group Types
var cpNumGroupTypes: Int?

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
public class GetGroups : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","CourseCode"]
}
}

/** 
  Get Groups Output. 
*/
@objc(GetGroupsOutput)
public class GetGroupsOutput : SyedAbsarObjectBase {


/// Num Groups
var cpNumGroups: Int?

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
public class SendMyGroups : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

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
public class SendMyGroupsOutput : SyedAbsarObjectBase {


/// Success
var cpSuccess: Int?

/// Num Groups
var cpNumGroups: Int?

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
public class GetDirectoryTree : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

/// Group Code
var cpGroupCode: Int?

/// Tree Code
var cpTreeCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","CourseCode","GroupCode","TreeCode"]
}
}

/** 
  Get Directory Tree Output. 
*/
@objc(GetDirectoryTreeOutput)
public class GetDirectoryTreeOutput : SyedAbsarObjectBase {


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
public class GetFile : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// File Code
var cpFileCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","FileCode"]
}
}

/** 
  Get File Output. 
*/
@objc(GetFileOutput)
public class GetFileOutput : SyedAbsarObjectBase {


/// File Name
var cpFileName: String?

/// U R L
var cpURL: String?

/// Size
var cpSize: Int?

/// Time
var cpTime: Int?

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
public class GetMarks : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// File Code
var cpFileCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","FileCode"]
}
}

/** 
  Get Marks Output. 
*/
@objc(GetMarksOutput)
public class GetMarksOutput : SyedAbsarObjectBase {


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
public class GetTestConfig : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","CourseCode"]
}
}

/** 
  Get Test Config Output. 
*/
@objc(GetTestConfigOutput)
public class GetTestConfigOutput : SyedAbsarObjectBase {


/// Pluggable
var cpPluggable: Int?

/// Num Questions
var cpNumQuestions: Int?

/// Min Questions
var cpMinQuestions: Int?

/// Def Questions
var cpDefQuestions: Int?

/// Max Questions
var cpMaxQuestions: Int?

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
public class GetTests : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

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
public class GetTestsOutput : SyedAbsarObjectBase {


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
public class GetTrivialQuestion : SyedAbsarObjectBase {


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
public class GetTrivialQuestionOutput : SyedAbsarObjectBase {


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
public class GetUsers : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

/// Group Code
var cpGroupCode: Int?

/// User Role
var cpUserRole: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","CourseCode","GroupCode","UserRole"]
}
}

/** 
  Get Users Output. 
*/
@objc(GetUsersOutput)
public class GetUsersOutput : SyedAbsarObjectBase {


/// Num Users
var cpNumUsers: Int?

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
public class GetAttendanceEvents : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","CourseCode"]
}
}

/** 
  Get Attendance Events Output. 
*/
@objc(GetAttendanceEventsOutput)
public class GetAttendanceEventsOutput : SyedAbsarObjectBase {


/// Num Events
var cpNumEvents: Int?

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
public class SendAttendanceEvent : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Attendance Event Code
var cpAttendanceEventCode: Int?

/// Course Code
var cpCourseCode: Int?

/// Hidden
var cpHidden: Int?

/// Start Time
var cpStartTime: Int?

/// End Time
var cpEndTime: Int?

/// Comments Teachers Visible
var cpCommentsTeachersVisible: Int?

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
public class SendAttendanceEventOutput : SyedAbsarObjectBase {


/// Attendance Event Code
var cpAttendanceEventCode: Int?

override static func cpKeys() -> Array<String> {
return ["AttendanceEventCode"]
}
}

/** 
  Get Attendance Users. 
*/
@objc(GetAttendanceUsers)
public class GetAttendanceUsers : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Attendance Event Code
var cpAttendanceEventCode: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","AttendanceEventCode"]
}
}

/** 
  Get Attendance Users Output. 
*/
@objc(GetAttendanceUsersOutput)
public class GetAttendanceUsersOutput : SyedAbsarObjectBase {


/// Num Users
var cpNumUsers: Int?

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
public class SendAttendanceUsers : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Attendance Event Code
var cpAttendanceEventCode: Int?

/// Users
var cpUsers: String?

/// Set Others As Absent
var cpSetOthersAsAbsent: Int?

override static func cpKeys() -> Array<String> {
return ["WsKey","AttendanceEventCode","Users","SetOthersAsAbsent"]
}
}

/** 
  Send Attendance Users Output. 
*/
@objc(SendAttendanceUsersOutput)
public class SendAttendanceUsersOutput : SyedAbsarObjectBase {


/// Success
var cpSuccess: Int?

/// Num Users
var cpNumUsers: Int?

override static func cpKeys() -> Array<String> {
return ["Success","NumUsers"]
}
}

/** 
  Get Notifications. 
*/
@objc(GetNotifications)
public class GetNotifications : SyedAbsarObjectBase {


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
public class GetNotificationsOutput : SyedAbsarObjectBase {


/// Num Notifications
var cpNumNotifications: Int?

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
public class MarkNotificationsAsRead : SyedAbsarObjectBase {


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
public class MarkNotificationsAsReadOutput : SyedAbsarObjectBase {


/// Num Notifications
var cpNumNotifications: Int?

override static func cpKeys() -> Array<String> {
return ["NumNotifications"]
}
}

/** 
  Send Notice. 
*/
@objc(SendNotice)
public class SendNotice : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Course Code
var cpCourseCode: Int?

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
public class SendNoticeOutput : SyedAbsarObjectBase {


/// Notice Code
var cpNoticeCode: Int?

override static func cpKeys() -> Array<String> {
return ["NoticeCode"]
}
}

/** 
  Send Message. 
*/
@objc(SendMessage)
public class SendMessage : SyedAbsarObjectBase {


/// Ws Key
var cpWsKey: String?

/// Message Code
var cpMessageCode: Int?

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
public class SendMessageOutput : SyedAbsarObjectBase {


/// Num Users
var cpNumUsers: Int?

/// Users Array
var cpUsersArray: String?

override static func cpKeys() -> Array<String> {
return ["NumUsers","UsersArray"]
}
}


/**
    A generic base class for all Objects.
*/
public class SyedAbsarObjectBase : NSObject
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