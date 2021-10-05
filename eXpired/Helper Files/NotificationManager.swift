//
//  NotificationManager.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 18/08/2021.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    
    func createNotification(brandName: String, brandId: String , expiryDate: String){
        let content = UNMutableNotificationContent()
        content.title = "ExPIRED"
        content.body = String(format: "%@ %@ %@", "Your product" , brandName , "has been expired in 28 days")
        content.sound = .default
        // dd-MMM-yyyy
        let expirydate = expiryDate.toDate(withFormat: "dd-MMM-yyyy") ?? Date()
        let notificationFireDate = Calendar.current.date(byAdding: .day, value: -28, to: expirydate)
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour]
        formatter.unitsStyle = .short
        let totalHours = formatter.string(from: Date(), to: notificationFireDate!) ?? "1"
        
        var dateComponent = DateComponents()
        dateComponent.hour = Int(totalHours)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: brandId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    
    func destroyeAllNotifications(){
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
    
    func updateNotification(brandName: String, brandId: String , expiryDate: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [brandId])
        createNotification(brandName: brandName, brandId: brandId, expiryDate: expiryDate)
    }
}
