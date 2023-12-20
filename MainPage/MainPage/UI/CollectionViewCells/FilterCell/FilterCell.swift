//
//  FilterCell.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 16.12.2023.
//

import UIKit
import AppResources

final class FilterCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    override class func description() -> String {
        return "FilterCell"
    }
    
    func configure(_ title: String, isSelected: Bool) {
        titleLabel.text = title
        changeSelectedState(isSelected)
    }
    
}

// MARK: - Private Extension
private extension FilterCell {
    
    func configUI() {
        layer.cornerRadius = 6.0
    }
    
    func changeSelectedState(_ isSelected: Bool) {
        titleLabel.textColor = isSelected ? UIColor.white : UIColor.black
        backgroundColor = isSelected ? UIColor.black : AppColors.white2
        layer.borderWidth = isSelected ? 0.0 : 0.5
        layer.borderColor = isSelected ? UIColor.clear.cgColor : AppColors.white3.cgColor
    }
    
}
