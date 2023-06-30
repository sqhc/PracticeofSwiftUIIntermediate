//
//  LocalNotificationsPractice.swift
//  PracticeofSwiftUIIntermediate
//
//  Created by 沈清昊 on 6/30/23.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager{
    
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error{
                print("ERROR: \(error)")
            } else{
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was sooooo easy!"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calender
//        var dateComponents = DateComponents()
//        dateComponents.hour = 13
//        dateComponents.minute = 53
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
        // location
        let coordinates = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelNotificaion(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationsPractice: View {
    var body: some View {
        VStack(spacing: 40){
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotificaion()
            }
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationsPractice_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsPractice()
    }
}
