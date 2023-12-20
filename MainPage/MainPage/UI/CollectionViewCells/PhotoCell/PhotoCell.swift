//
//  PhotoCell.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 19.12.2023.
//

import UIKit
import AppResources
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    override class func description() -> String {
        return "PhotoCell"
    }
    
    func configure(_ imageUrl: String) {
        photoImageView.kf.setImage(with: URL(string: imageUrl))
    }

}

// MARK: - Private Extension
private extension PhotoCell {
    
    func configUI() {
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = AppColors.white4.cgColor
    }
    
}
