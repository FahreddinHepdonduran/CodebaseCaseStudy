//
//  HeaderView.swift
//  UIComponents
//
//  Created by Fahreddin Hepdonduran on 18.12.2023.
//

import UIKit
import AppResources
import Kingfisher

public final class HeaderView: UIView {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rightItemsStack: UIStackView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    public override class func description() -> String {
        return "HeaderView"
    }
    
    public func setImage(_ imageUrl: String) {
        profileImageView.kf.setImage(with: URL(string: imageUrl))
    }
    
    public func setTitle(_ title: String) {
        addAttributedTitleText(title)
    }
    
    public func addRightItem(_ view: UIView) {
        rightItemsStack.addArrangedSubview(view)
    }
    
}

// MARK: - Private Extension
private extension HeaderView {
    
    func commonInit() {
        guard let bundle = Bundle.AppBundle.UIComponents.initBundle,
              let view = bundle.loadNibNamed(Self.description(), owner: self, options: nil)![0] as? UIView
        else {
            return
        }
        
        view.frame = self.bounds
        addSubview(view)
    }
    
    func configUI() {
        profileImageView.setRadius(radius: profileImageView.bounds.height / 2)
        addShadow(offset: .init(width: 0.0, height: 0.0), radius: 20.0, opacity: 1.0, color: .black.withAlphaComponent(0.1))
    }
    
    func addAttributedTitleText(_ text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        
        let fullText = "Hello,\n" + text
        titleLabel.text = fullText
    }
    
}
