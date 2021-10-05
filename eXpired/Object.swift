//
//  Object.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 01/08/2021.
//

import Foundation


struct localUser : Codable{
    var userId: String = ""
    var name: String = ""
    var email: String = ""
}

struct Category {
    var id : String = ""
    var name: String = ""
}

struct Product {
    var id: String = ""
    var brand: String = ""
    var shade: String = ""
    var datePurchase: String = ""
    var dateOpened: String = ""
    var dateExpiry: String = ""
    var month: String = ""
    var imageUrl: String = ""
    var notificationId: String = ""
}
