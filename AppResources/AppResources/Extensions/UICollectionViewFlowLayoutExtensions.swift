import Foundation
import UIKit

public extension UICollectionViewFlowLayout {
    
    class func generateOne(
        _ direction: UICollectionView.ScrollDirection, _ itemSize: CGSize, _ insets: UIEdgeInsets,
        _ lineSpacing: CGFloat, _ interitemSpacing: CGFloat
    ) -> Self
    {
        let layout = self.init()
        layout.scrollDirection = direction
        layout.itemSize = itemSize
        layout.sectionInset = insets
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        return layout
    }
    
}
