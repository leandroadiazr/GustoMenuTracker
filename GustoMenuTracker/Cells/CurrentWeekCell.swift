//
//  CurrentWeekCell.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/18/21.
//

import UIKit
import Anchorage

class CurrentWeekCell: UICollectionViewCell, SelfConfiguringCell {
    struct Layout {
        static let cornerRadius = CGFloat(16)
        static let edgeInsets = CGFloat(7)
    }
    
    static var reuseID = "CurrentWeekCell"
    
    let titleLabel = CustomTitleLabel(textAlignment: .left, fontSize: 14)
    let detailsLabel = CustomBodyLabel(textAlignment: .justified, fontSize: 12)
    
    let viewImage: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = Layout.cornerRadius
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to order", for: .normal)
        button.setTitleColor(CustomColors.CustomGreenColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        return button
    }()
    
    var buttonAction: VoidClosure?
    
    @objc func followAction() {
        self.buttonAction?()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with menu: Menu) {
        titleLabel.text = menu.itemTitle
        detailsLabel.text = menu.itemDescription
        viewImage.image = UIImage(named: menu.itemImage)
    }
    
    private func configureViews() {
        addCustomShadow(view: self)
        backgroundColor = CustomColors.CustomBeigeColor
        addSubview(titleLabel)
        detailsLabel.numberOfLines = 2
        addSubview(detailsLabel)
        contentView.addSubview(viewImage)
        addSubview(actionButton)
        layer.cornerRadius = Layout.cornerRadius
        setupConstraints()
    }
    
    private func setupConstraints() {
        viewImage.topAnchor == contentView.topAnchor
        viewImage.leadingAnchor == contentView.leadingAnchor
        viewImage.trailingAnchor == contentView.trailingAnchor
        viewImage.heightAnchor == heightAnchor / 2
        
        titleLabel.topAnchor == viewImage.bottomAnchor
        titleLabel.leadingAnchor == leadingAnchor + Layout.edgeInsets
        titleLabel.trailingAnchor == centerXAnchor + Layout.edgeInsets
        
        detailsLabel.topAnchor == titleLabel.bottomAnchor
        detailsLabel.leadingAnchor == leadingAnchor + Layout.edgeInsets
        detailsLabel.trailingAnchor == trailingAnchor - Layout.edgeInsets
        
        actionButton.trailingAnchor == trailingAnchor - Layout.edgeInsets
        actionButton.bottomAnchor == bottomAnchor - Layout.edgeInsets
        actionButton.widthAnchor == 74
        actionButton.heightAnchor == 18
    }
}
