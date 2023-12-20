import Foundation
import UIKit

public extension UIView {
    
    func setRadius(radius: CGFloat, corners:CACornerMask = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]) {
        layer.maskedCorners = corners
        layer.cornerRadius  = radius
        layer.masksToBounds = true
    }
    
    func addShadow(offset: CGSize = CGSize(width: 0, height: 6), radius: CGFloat = 6, opacity: Float = 0.7, color: UIColor = .lightGray) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    
}
