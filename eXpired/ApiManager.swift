//
//  ApiManager.swift
//  DeliciousFood
//
//  Created by Malik Farhan Asim on 23/06/2021.
//

import FirebaseStorage
import FirebaseFirestore
import Firebase
import Alamofire
import UIKit


enum CategoriesOptions : String {
    case makeup = "MakeUp"
    case skinCare = "Skin Care"
    case perfume = "Perfume"
}

class ApiManager {
    
    var db : Firestore? = nil

    
    init() {
        db = Firestore.firestore()
    }
    static let shared = ApiManager()
    
    func signIn(_ email: String , _ password: String , completion: @escaping(_ user: User? , _ error: String?)->()){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let user = user {
                
                self?.db?.collection("user").document(user.user.uid).getDocument(completion: { response, error in
                    if let res = response {
                        var object = localUser()
                        if let value = res.data() {
                            if let name =  value["name"] as? String {
                                object.name = name
                            }
                            if let email = value["email"] as? String {
                                object.email = email
                            }
                            
                            object.userId = user.user.uid
                            DataManager.shared.saveUserData(user: object)
                            completion(user.user , nil)
                        }
                    }
                    if let error = error {
                        print(error.localizedDescription)
                    }

                })
            }
            if let error = error {
                completion(nil , error.localizedDescription)
            }
        }
    }
    
    func createUser(_ email: String , _ password: String , _ name: String , completion: @escaping(_ success: String? , _ error: String?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if let user = user {
                self?.db?.collection("user").document(user.user.uid).setData(["email": email , "name" : name , "id": user.user.uid])
                completion("User Created Successfuly", nil)
            }
            if let erro = error {
                completion(nil , erro.localizedDescription)
            }
        }
        
    }
    
    func createCategory(_ categoryOption: CategoriesOptions,_ categoryName: String){
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).addDocument(data: [
            "categoryName" : categoryName
        
        ], completion: { error in
            
        })
    }
    
    func deleteCategory(_ categoryOption: CategoriesOptions, _ categoryId: String){
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).document(categoryId).delete()
    }
    
    
    func getAllCategories(_ categoryOption: CategoriesOptions, completion: @escaping(_ categories: [Category]?) -> ()){
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).getDocuments(completion: { snapShot, error in
            
            var object = Category()
            var objectToReturn = [Category]()
            if let document = snapShot?.documents {
                for document in document {
                    
                    if let name = document["categoryName"] as? String {
                        object.name = name
                    }
                    object.id = document.documentID
                    objectToReturn.append(object)
                }
                completion(objectToReturn)
            }
        })
    }
    
    func addProductIntoCategory(_ categoryOption: CategoriesOptions ,_ categoryId: String, _ brandName: String, _ shade: String, _ datePurchase: String, _ dateOpened: String, _ dateExpiry: String, _ month: String, _ imageUrl: String, notificationId: String){
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).document(categoryId).collection("Product").addDocument(data: [
            "brandName" : brandName,
            "shade" : shade,
            "datePurchase" : datePurchase,
            "dateOpened" : dateOpened,
            "dateExpiry" : dateExpiry,
            "month" : month,
            "imageUrl" : imageUrl,
            "notificationId": notificationId
        ])
    }
    
    func updateProductIntoCategory(_ categoryOption: CategoriesOptions ,_ categoryId: String, _ brandName: String, _ shade: String, _ datePurchase: String, _ dateOpened: String, _ dateExpiry: String, _ month: String, _ imageUrl: String , productId: String , notificationId: String){
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).document(categoryId).collection("Product").document(productId).updateData([
            "brandName" : brandName,
            "shade" : shade,
            "datePurchase" : datePurchase,
            "dateOpened" : dateOpened,
            "dateExpiry" : dateExpiry,
            "month" : month,
            "imageUrl" : imageUrl,
            "notificationId" : notificationId
        ])
    }
    
    func deleteProduct(_ categoryOption: CategoriesOptions, _ categoryId: String , _ productId: String){
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).document(categoryId).collection("Product").document(productId).delete()
    }
    
    func getAllProducts(_ categoryOption: CategoriesOptions , _ categoryId: String, completion: @escaping(_ products: [Product]?) -> ()) {
        let userId = DataManager.shared.getUserData()?.userId ?? ""
        let path = String(format: "%@_%@", categoryOption.rawValue, "category")
        db?.collection("user").document(userId).collection(path).document(categoryId).collection("Product").getDocuments(completion: { snapShot, error in
            var object = Product()
            var objectToReturn = [Product]()
            if let document = snapShot?.documents {
                for document in document {
                    if let brandName = document["brandName"] as? String {
                        object.brand = brandName
                    }
                    if let dateExpiry = document["dateExpiry"] as? String {
                        object.dateExpiry = dateExpiry
                    }
                    if let dateOpened = document["dateOpened"] as? String {
                        object.dateOpened = dateOpened
                    }
                    if let datePurchase = document["datePurchase"] as? String {
                        object.datePurchase = datePurchase
                    }
                    if let imageUrl = document["imageUrl"] as? String {
                        object.imageUrl = imageUrl
                    }
                    if let month = document["month"] as? String {
                        object.month = month
                    }
                    if let shade = document["shade"] as? String {
                        object.shade = shade
                    }
                    if let notificationId = document["notificationId"] as? String {
                        object.notificationId = notificationId
                    }
                    object.id = document.documentID
                    objectToReturn.append(object)
                }
                completion(objectToReturn)
            }
        })
    }
    
    func uploadMedia(image : UIImage ,completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("user").child("\(String.random()).png")
       if let uploadData = image.jpegData(compressionQuality: 0.5) {
           storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
               if error != nil {
                   print("error")
                   completion(nil)
               } else {

                   storageRef.downloadURL(completion: { (url, error) in

                    print(url?.absoluteString ?? "")
                       completion(url?.absoluteString)
                   })
               }
           }
       }
   }
    
}
