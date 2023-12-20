//
//  TagCell.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 16.12.2023.
//

import UIKit
import AppResources

final class TagCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    override class func description() -> String {
        return "TagCell"
    }
    
    func configure(_ title: String, _ row: Int, type: CardType) {
        titleLabel.text = title
        
        let flag = (row % 2 == 0)
        
        if type == .realEstate {
            backgroundColor = flag ? AppColors.pink1 : AppColors.green1
            return
        }
        
        backgroundColor = flag ? AppColors.pink1 : AppColors.blue1
    }

}

// MARK: - Private Extension
private extension TagCell {
    
    func configUI() {
        setRadius(radius: 6.0)
    }
    
}
