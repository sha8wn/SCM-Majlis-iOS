//
//  FirebaseAnalyticsManager.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/12/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation
import Firebase

enum FirebaseEvent: String{
    
    //Screen Event
    case RegisterActivity = "Register_Screen"
    case LoginActivity = "Login_Screen"
    case EventListActivity = "Home_Event"
    case EventDetailActivity = "Event_Detail_Screen"
    case PastEventActivity = "Past_Event_Screen"
    case UserGoingActivity = "Going_To_Event_Screen"
    case EventRegisterActivity = "Event_Reservation_Screen"
    case SettingActivity = "Settings_Screen"
    case ManageSuperCarsActivity = "Manage_Car_Screen"
    case ManageDocumentActivity = "Manage_Documents_Screen"
    case FeedbackActivity = "Contact_Screen"
    case PromotionActivity = "Promotion_Screen"
    case PromotionDetailActivity = "Promotion_Detail_Screen"
    
    //Functional Events
    case EventRegisteredSuccess = "Event_Registration_Success"
    case PromotionRedeemedSuccess = "Promotion_Redemption_Success"
    
    
//    //Screen Event
//    case RegisterActivity = "RegisterActivity"
//    case LoginActivity = "LoginActivity"
//    case EventListActivity = "EventListHomeActivity"
//    case EventDetailActivity = "EventDetailActivity"
//    case PastEventActivity = "PastEventActivity"
//    case UserGoingActivity = "UserGoingActivity"
//    case EventRegisterActivity = "EventRegisterActivity"
//    case SettingActivity = "SettingActivity"
//    case ManageSuperCarsActivity = "ManageSuperCarsActivity"
//    case ManageDocumentActivity = "ManageDocumentActivity"
//    case FeedbackActivity = "FeedbackActivity"
//    case PromotionActivity = "PromotionActivity"
//    case PromotionDetailActivity = "PromotionDetailActivity"
//
//    //Functional Events
//    case EventRegisteredSuccess = "EventRegisteredSuccessfully"
//    case PromotionRedeemedSuccess = "PromotionRedeemedSuccessfully"
}

class FirebaseAnalyticsManager{
    static let shared = FirebaseAnalyticsManager()
    
    func logEvent(eventName: String){
        Analytics.logEvent(eventName, parameters: [:])
    }
    
}
