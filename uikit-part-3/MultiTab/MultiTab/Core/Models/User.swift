//
//  User.swift
//  MultiTab
//
//  Created by Marcin Wawer on 21-06-2025.
//

import Foundation

enum NotificationPreference: String {
    case email = "Email Notifications"
    case sms = "SMS Notifications"
    case push = "Push Notifications"
}

final class User {
    
    static let shared = User()
    
    var name: String?
    var phoneNumber: String?
    var notificactionPreference: NotificationPreference?
    var isRegistered = false
    
    private init() { }
    
    func clearUserData() {
        name = nil
        phoneNumber = nil
        notificactionPreference = nil
        isRegistered = false
    }
}
