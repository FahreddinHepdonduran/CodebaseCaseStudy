//
//  FilterHeaderView.swift
//  MainPage
//
//  Created by Fahreddin Hepdonduran on 20.12.2023.
//

import UIKit
import AppResources

protocol FilterHeaderViewDelegate: AnyObject {
    func filterFor(type: CardType)
}

final class FilterHeaderView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var options: [CardType]?
    private var currentOption: CardType?
    
    weak var delegate: FilterHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        registerCell()
        setItemSizes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override class func description() -> String {
        return "FilterHeaderView"
    }
    
    func configure(_ title: String, _ options: [CardType], _ currentOption: CardType) {
        titleLabel.text = title
        
        self.currentOption = currentOption
        self.options = options
    }

}

// MARK: - UICollectionViewDataSource
extension FilterHeaderView: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.description(), for: indexPath) as! FilterCell
        
        if let options, let currentOption {
            let model = options[indexPath.row]
            cell.configure(model.getTitle, isSelected: model == currentOption)
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension FilterHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let options {
            delegate?.filterFor(type: options[indexPath.row])
        }
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FilterHeaderView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 100.0, height: 10.0)
    }
    
}

// MARK: - Private Extension
private extension FilterHeaderView {
    
    func commonInit() {
        guard let bundle = Bundle.AppBundle.MainPage.initBundle,
              let view = bundle.loadNibNamed(Self.description(), owner: self, options: nil)![0] as? UIView
        else {
            return
        }
        
        view.frame = self.bounds
        addSubview(view)
    }
    
    func registerCell() {
        collectionView.register(
            UINib(nibName: FilterCell.description(), bundle: .AppBundle.MainPage.initBundle),
            forCellWithReuseIdentifier: FilterCell.description()
        )
    }
    
    func setItemSizes() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.minimumLineSpacing = 8.0
        }
    }
    
}
