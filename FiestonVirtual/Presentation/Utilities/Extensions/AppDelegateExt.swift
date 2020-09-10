//
//  AppDelegateExt.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Firebase

// MARK:  iOS 10 Message Handling
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // This method is called when the app is in Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        // Change this to your preferred presentation option
        completionHandler([UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.sound])
    }
    
    // This method is called when user tap on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print full message.
        Log.i("tap on on foreground app \(userInfo)")
        completionHandler()
    }
}

// MARK: FCM Token
extension AppDelegate: MessagingDelegate {
    
    // Refresh Token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        Log.i("Firebase registration token: \(fcmToken)")
        let dataDict: [String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
    }
    
}
