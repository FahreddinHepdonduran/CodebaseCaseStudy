import Foundation
import UIKit

public protocol AlertShowable: UIViewController {
    func showAlert(_ parent: UIViewController, _ title: String, _ description: String)
}

public extension AlertShowable {
    
    func showAlert(_ parent: UIViewController, _ title: String, _ description: String) {
        DispatchQueue.main.async {
            let action = UIAlertAction(title: "Ok", style: .cancel)
            
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alert.addAction(action)
            
            parent.present(alert, animated: true)
        }
    }
    
}
