//
//  ApiManager.swift
//  DeliciousFood
//
//  Created by Malik Farhan Asim on 23/06/2021.
//

import Foundation
//import FirebaseStorage
//import Firebase

//class ApiManager {
//
//    var ref: DatabaseReference!
//
//    init() {
//        ref = Database.database().reference()
//    }
//    static let shared = ApiManager()
//
//
//
//    func getRestaurantData(completion : @escaping(_ model : [RestaurantModel]?) -> Void){
//        ref.child("Restaurant").observe(.value) { (snapshot) in
//
//            var restaurantObject = [RestaurantModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let image = value["imageUrl"] as! String
//                    let deliveryTime = value["deliveryTime"] as! String
//                    let deliveryCharges = value["deliveryCharges"] as! String
//
//                    let object = RestaurantModel(name: name, deliveryTime: deliveryTime,deliveryCharges: deliveryCharges ,imageurl: image, key: snap.key , isHomeService: false)
//                    restaurantObject.append(object)
//                 }
//            }
//            completion(restaurantObject)
//        }
//    }
//
//
//    func getHomeData(completion : @escaping(_ model : [RestaurantModel]?) -> Void){
//        ref.child("HomeService").observe(.value) { (snapshot) in
//
//
//            var restaurantObject = [RestaurantModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let image = value["imageUrl"] as! String
//                    let deliveryTime = value["deliveryTime"] as! String
//                    let deliveryCharges = value["deliveryCharges"] as! String
//
//                    let object = RestaurantModel(name: name, deliveryTime: deliveryTime,deliveryCharges: deliveryCharges ,imageurl: image , key: snap.key, isHomeService: true)
//                    restaurantObject.append(object)
//                 }
//            }
//            completion(restaurantObject)
//        }
//    }
//
//
//
//
//    func getCategories(restaurantType : Restaturant, key: String , completion : @escaping (_ category: [CateogryModel]?) -> Void){
//        ref.child(restaurantType.rawValue).child(key).child("Category").observe(.value) { (snapshot) in
//
//            var catObject = [CateogryModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let image = value["imageUrl"] as! String
//
//                    let object = CateogryModel(name: name, imageUrl: image, key: snap.key)
//                    catObject.append(object)
//                 }
//            }
//            completion(catObject)
//        }
//    }
//
//
//    func getItem(restaurantType : Restaturant, key: String , categoryKey: String , completion : @escaping (_ category: [ItemModel]?) -> Void){
//        ref.child(restaurantType.rawValue).child(key).child("Category").child(categoryKey).child("Item").observe(.value) { (snapshot) in
//
//            var itemObject = [ItemModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                var name = ""
//                var price = ""
//                var image = ""
//                var addOnTitle = ""
//                var itemDescription = ""
//
//
//                if let value = snap.value as? [String : Any] {
//                    if let nameString = value["name"] as? String {
//                        name = nameString
//                    }
//                    if  let priceString = value["price"] as? String {
//                        price = priceString
//                    }
//                    if let imageString = value["imageUrl"] as? String {
//                        image = imageString
//                    }
//                    if let description = value["description"] as? String {
//                        itemDescription = description
//                    }
//                    if let addOnTitleString = value["addOnTitle"] as? String {
//                        addOnTitle = addOnTitleString
//                    }
//
//                    let object = ItemModel(name: name, price: price , imageUrl: image,itemDescription: itemDescription ,key: snap.key, addOnTitle: addOnTitle)
//                    itemObject.append(object)
//                 }
//            }
//            completion(itemObject)
//        }
//    }
//
//
//    func getAddOns(restaurantType : Restaturant, key: String ,itemKey: String  ,completion : @escaping (_ addOns: [addOnsModel]?) -> Void){
//        ref.child(restaurantType.rawValue).child(key).child("Item").child(itemKey).child("AddOns").observe(.value) { (snapshot) in
//
//            var addOnObject = [addOnsModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let price = value["price"] as! String
//                    let object = addOnsModel(name: name, price: price, key: snap.key)
//                    addOnObject.append(object)
//                 }
//            }
//            completion(addOnObject)
//        }
//}

