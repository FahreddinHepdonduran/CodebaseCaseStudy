import Foundation
import UIKit
import CoreText

public enum AppFonts: String {
    case SF_Pro_Text_Bold = "SF-Pro-Text-Bold"
    case SF_Pro_Text_Medium = "SF-Pro-Text-Medium"
    case SF_Pro_Text_Regular = "SF-Pro-Text-Regular"
    case SF_Pro_Text_SemiBold = "SF-Pro-Text-Semibold"
}

public extension AppFonts {
    
    func withSize(_ size: CGFloat) -> UIFont {
        UIFont(name: self.rawValue, size: size) ?? .systemFont(ofSize: 10.0)
    }
    
}
