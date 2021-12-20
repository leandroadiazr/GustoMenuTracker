//
//  FeaturedCell.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/18/21.
//

import UIKit
import Anchorage

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    
    struct Layout {
        static let cornerRadius = CGFloat(16)
        static let edgeInsets = CGFloat(15)
    }
    
    static let reuseID = "FeaturedCell"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()
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
        button.backgroundColor = .white
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 16
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
        backgroundColor = .white
        addSubview(titleLabel)
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
        viewImage.heightAnchor == heightAnchor / 1.5
        
        titleLabel.topAnchor == viewImage.bottomAnchor
        titleLabel.leadingAnchor == leadingAnchor + Layout.edgeInsets
        titleLabel.trailingAnchor == centerXAnchor + Layout.edgeInsets
        
        detailsLabel.topAnchor == titleLabel.bottomAnchor
        detailsLabel.leadingAnchor == leadingAnchor + Layout.edgeInsets
        detailsLabel.trailingAnchor == centerXAnchor - Layout.edgeInsets
        
        actionButton.centerYAnchor == detailsLabel.centerYAnchor
        actionButton.leadingAnchor == detailsLabel.trailingAnchor + Layout.edgeInsets * 2
        actionButton.trailingAnchor == trailingAnchor - Layout.edgeInsets
    }
}
