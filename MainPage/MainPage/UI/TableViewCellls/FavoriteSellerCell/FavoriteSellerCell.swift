//
//  FavoriteSellerCell.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 16.12.2023.
//

import UIKit
import AppResources
import Kingfisher

protocol FavoriteSellerCellDelegate: AnyObject {
    func didSelectFav(_ flag: Bool, _ model: CardDomainModel, _ index: Int)
}

final class FavoriteSellerCell: UITableViewCell {
    
    @IBOutlet private weak var allContainerView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var favButton: UIButton!
    
    private var isFav = false
    private var model: CardDomainModel?
    private var index: Int?
    
    weak var delegate: FavoriteSellerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override class func description() -> String {
        return "FavoriteSellerCell"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    @IBAction func favBtnAction(_ sender: UIButton) {
        isFav.toggle()
        changeFavButtonImage()
        
        if let model, let index {
            delegate?.didSelectFav(isFav, model, index)
        }
    }
    
    func configure(_ model: CardDomainModel, _ isSelected: Bool, _ index: Int) {
        self.model = model
        self.index = index
        
        profileImageView.kf.setImage(with: URL(string: model.profileImage ?? ""))
        nameLabel.text = model.name ?? "John Doe"
        dateLabel.text = "Üyelik tarihi: " + (model.registerDate ?? "12.01.2023")
        
        isFav = isSelected
        changeFavButtonImage()
    }
    
}

// MARK: - Private Extension
private extension FavoriteSellerCell {
    
    func configUI() {
        allContainerView.layer.cornerRadius = 12
        allContainerView.layer.borderWidth = 1
        allContainerView.layer.borderColor = AppColors.white6.cgColor
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
    }
    
    func changeFavButtonImage() {
        favButton.setImage(
            isFav ? AppIcons.favoriteSelectedIcon : AppIcons.favouriteUnselectedIcon,
            for: .normal
        )
    }
    
}
