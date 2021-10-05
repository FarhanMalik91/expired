//
//  Extensionss.swift
//  DeliciousFood
//
//  Created by Malik Farhan Asim on 05/04/2021.
//

import Foundation
import UIKit
import JGProgressHUD
import SDWebImage

enum fontName : String {
   case Poppins_Light = "Poppins-Light"
   case Poppins_Medium = "Poppins-Medium"
   case Poppins_Regular = "Poppins-Regular"
   case Poppins_Bold = "Poppins-Bold"
   case Poppins_SemiBold = "Poppins-SemiBold"
   case Poppins_ExtraLight = "Poppins-ExtraLight"
}

let hud = JGProgressHUD()


extension UIFont {

   static func setFont(fontName: fontName , fontSize: CGFloat) -> UIFont {
        
        let font = UIFont(name: fontName.rawValue, size: fontSize)!
        return font
    }
}
extension Int{
    var autoSized : CGFloat{
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let diagonalSize = sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight))
        let percentage = CGFloat(self)/894*100 //894 is the diagonal size of iphone xs / 11pro
        return diagonalSize * percentage / 100
    }
    
    var widthRatio: CGFloat {
        let width = UIScreen.main.bounds.width/375.0 //iphone 11 pro
        return CGFloat(self)*width
    }
    var heightRatio: CGFloat {
        let width = UIScreen.main.bounds.height/812.0 //iphone 11 pro
        return CGFloat(self)*width
    }
}

extension UICollectionViewCell {
    func shadowDecorate() {

        self.layer.cornerRadius = 5.autoSized
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = #colorLiteral(red: 0.2274509804, green: 0.2274509804, blue: 0.2274509804, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 3)
        self.layer.shadowRadius = 7.5
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
        
    }
}

extension UIImageView{
    func downloadImage(url:String){
      //remove space if a url contains.
        let stringWithoutWhitespace = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
//        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage())
        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage(), options: [.progressiveLoad , .highPriority], progress: nil, completed: nil)
    }
}

extension UIViewController {
    func showLoadingView(){
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    }
    
    func hideLoadingView(){
        hud.dismiss()
    }
    func showAlertWithSingleButton(_ title: String, _ message:String , completion: @escaping() -> Void?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            completion()
        })
        alert.addAction(ok)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    func showAlertWithDobuleButton(_ title: String, _ message:String , completion: @escaping() -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
           
        })
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            completion()
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
    }
    func dropShadow() {

        self.layer.cornerRadius = 5.autoSized
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = #colorLiteral(red: 0.1882352941, green: 0.1882352941, blue: 0.1882352941, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3.5
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
    }
}
extension UICollectionViewCell {
    func applyShadow() {

        self.layer.cornerRadius = 10.autoSized
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
        
    }
}

extension UIView {
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}
extension UILabel {

    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
}

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
}
extension UITextField {

  func addInputViewDatePicker(target: Any, selector: Selector) {

   let screenWidth = UIScreen.main.bounds.width

   //Add DatePicker as inputView
   let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
   datePicker.datePickerMode = .date
   self.inputView = datePicker

   //Add Tool Bar as input AccessoryView
   let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
   let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
   let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
   let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
   toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

   self.inputAccessoryView = toolBar
}

  @objc func cancelPressed() {
    self.resignFirstResponder()
  }
}
extension String {
    static func random(length: Int = 20) -> String {
       let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
       return String((0..<length).map{ _ in letters.randomElement()! })
     }
}

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}

extension Date {

    func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}

extension UIViewController {
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle:String? = "Add",
                         cancelTitle:String? = "Cancel",
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                         actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
}
