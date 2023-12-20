import Foundation
import AppResources
import UIKit

public final class FilterButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(AppIcons.filterIcon, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
