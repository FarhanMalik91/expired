//
//  Extensionss.swift
//  DeliciousFood
//
//  Created by Malik Farhan Asim on 05/04/2021.
//

import Foundation
import UIKit


enum fontName : String {
   case Poppins_Light = "Poppins-Light"
   case Poppins_Medium = "Poppins-Medium"
   case Poppins_Regular = "Poppins-Regular"
   case Poppins_Bold = "Poppins-Bold"
   case Poppins_SemiBold = "Poppins-SemiBold"
    case Poppins_ExtraLight = "Poppins-ExtraLight"

}

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
//    func downloadImage(url:String){
//      //remove space if a url contains.
//        let stringWithoutWhitespace = url.replacingOccurrences(of: " ", with: "%20", options: .regularExpression)
//        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
////        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage())
//        self.sd_setImage(with: URL(string: stringWithoutWhitespace), placeholderImage: UIImage(), options: [.progressiveLoad , .highPriority], progress: nil, completed: nil)
//    }
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
