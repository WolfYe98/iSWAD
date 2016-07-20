//
//  Constants.swift
//  iSWAD
//
//  Created by Raul Alvarez on 08/06/2016.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation

struct Constants {
	static let userIDKey = "userID"
	static let userPassworKey = "userPassword"
	static let appKey = "iTorres"
	static let logged = "loggedStatus"
	static let wsKey = "wsKey"
	static let userFirstnameKey = "userFirstname"
	static let userSurname1Key = "userSurname1"
	static let userSurname2Key = "userSurname2"
	static let serverURLKey = "serverURL"
	
	enum notificationType : String {
		case documentFile = "documentFile"
		case teachersFile = "teachersFile"
		case sharedFile = "sharedFile"
		case assignment = "assignment"
		case examAnnouncement = "examAnnouncement"
		case marksFile = "marksFile"
		case enrollmentStudent = "enrollmentStudent"
		case enrollmentTeacher = "enrollmentTeacher"
		case enrollmentRequest = "enrollmentRequest"
		case timelineComment = "timelineComment"
		case timelineFav = "timelineFav"
		case timelineShare = "timelineShare"
		case timelineMention = "timelineMention"
		case follower = "follower"
		case forumPostCourse = "forumPostCourse"
		case forumReply = "forumReply"
		case notice = "notice"
		case message = "message"
		case survey = "survey"
	}
	

}