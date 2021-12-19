//
//  NextWeekMenu.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit
import Anchorage

class NextWeekCell: UICollectionViewCell, SelfConfiguringCell {
    struct Layout {
        static let cornerRadius = CGFloat(16)
        static let edgeInsets = CGFloat(7)
    }
    
    static var reuseID = "NextWeekCell"

    let viewImage: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = Layout.cornerRadius
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Details", for: .normal)
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
        viewImage.image = UIImage(named: menu.itemImage)
    }

    private func configureViews() {
        addCustomShadow(view: self)
        layer.cornerRadius = Layout.cornerRadius
        backgroundColor = CustomColors.CustomGreenColor
        addSubview(viewImage)
        viewImage.image = UIImage(named: "Sushi")
        addSubview(actionButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        viewImage.topAnchor == contentView.topAnchor
        viewImage.leadingAnchor == contentView.leadingAnchor
        viewImage.trailingAnchor == contentView.trailingAnchor
        viewImage.heightAnchor == heightAnchor / 1.2
        
        actionButton.centerXAnchor == centerXAnchor
        actionButton.bottomAnchor == bottomAnchor - Layout.edgeInsets
        actionButton.widthAnchor == 64
        actionButton.heightAnchor == 18
    }
}
