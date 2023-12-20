import Foundation
import UIKit

public extension Bundle {
    
    enum AppBundle: String {
        case AppResources = "com.demo.AppResources"
        case Core = "com.demo.Core"
        case MainPage = "com.demo.MainPage"
        case UIComponents = "com.demo.UIComponents"
        
        public var initBundle: Bundle? {
            return Bundle(identifier: self.rawValue)
        }
    }
    
}
