//
//  ClothingCell.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 16.12.2023.
//

import UIKit
import AppResources

final class ClothingCell: UITableViewCell {
    
    @IBOutlet private weak var allContainerView: UIView!
    @IBOutlet private weak var photoCollection: UICollectionView!
    @IBOutlet private weak var tagCollection: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var inspectBtn: UIButton!
    @IBOutlet private weak var giveOfferBtn: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var tagCollectionHeight: NSLayoutConstraint!
    
    private var model: CardDomainModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setItemSizes()
        configUI()
    }
    
    override class func description() -> String {
        return "ClothingCell"
    }
    
    @IBAction
    private func inspectBtnAction(_ sender: UIButton) { }
    
    @IBAction
    private func giveOfferBtnAction(_ sender: UIButton) { }
    
    func configure(_ model: CardDomainModel) {
        self.model = model
        
        titleLabel.text = model.title ?? ""
        
        if let currency = model.currency {
            priceLabel.text = (currency.isEmpty ? "₺" : currency) + PriceFormatter().format(price: model.price ?? 1500)
        }
        
        priceLabel.text = "₺" + PriceFormatter().format(price: model.price ?? 1500)
        
        tagCollection.reloadData()
        photoCollection.reloadData()
        
        setTagCollectionHeight()
        
        setupPageControll()
    }
    
}

// MARK: - UICollectionViewDataSource
extension ClothingCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollection {
            return model?.badges?.count ?? 0
        }
        
        return model?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.description(), for: indexPath) as! TagCell
            
            if let model, let badges = model.badges {
                cell.configure(badges[indexPath.row], indexPath.row, type: .clothing)
            }
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.description(), for: indexPath) as! PhotoCell
        
        if let model, let images = model.images {
            cell.configure(images[indexPath.row])
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension ClothingCell: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == photoCollection else { return }
        
        let visibleRect = CGRect(origin: photoCollection.contentOffset, size: photoCollection.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        if let indexPath = photoCollection.indexPathForItem(at: visiblePoint) {
            pageControl.currentPage = indexPath.row
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ClothingCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == photoCollection {
            return .init(width: photoCollection.bounds.width, height: photoCollection.bounds.height)
        }
        
        return .init(width: 100.0, height: 35.0)
    }
    
}

// MARK: - Private Extension
private extension ClothingCell {
    
    func configUI() {
        allContainerView.layer.cornerRadius = 12
        allContainerView.layer.borderWidth = 1
        allContainerView.layer.borderColor = AppColors.white6.cgColor
        allContainerView.addShadow(offset: .init(width: 0.0, height: 2.0), radius: 8.0, opacity: 1.0, color: .black.withAlphaComponent(0.05))
        
        inspectBtn.layer.cornerRadius = 8.0
        inspectBtn.layer.borderWidth = 1.5
        inspectBtn.layer.borderColor = UIColor.black.cgColor
        
        giveOfferBtn.layer.cornerRadius = 8.0
    }
    
    func registerCells() {
        tagCollection.register(
            UINib(nibName: TagCell.description(), bundle: .AppBundle.MainPage.initBundle),
            forCellWithReuseIdentifier: TagCell.description()
        )
        
        photoCollection.register(
            UINib(nibName: PhotoCell.description(), bundle: .AppBundle.MainPage.initBundle),
            forCellWithReuseIdentifier: PhotoCell.description()
        )
    }
    
    func setItemSizes() {
        photoCollection.collectionViewLayout = UICollectionViewFlowLayout.generateOne(
            .horizontal, .init(width: photoCollection.bounds.width, height: photoCollection.bounds.height),
            .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), 0.0, 0.0
        )
        
        if let flowLayout = tagCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumLineSpacing = 4.0
        }
    }
    
    func setupPageControll() {
        guard let model else { return }
        
        if let images = model.images, images.count > 1 {
            pageControl.isHidden = false
            pageControl.numberOfPages = images.count
            pageControl.currentPage = 0
            return
        }
        
        pageControl.isHidden = true
    }
    
    func setTagCollectionHeight() {
        guard let model else { return }
        
        if let badges = model.badges, badges.count != 0 {
            tagCollectionHeight.constant = 35.0
            layoutIfNeeded()
            return
        }
        
        tagCollectionHeight.constant = 0.0
        
        layoutIfNeeded()
    }
    
}
