//
//  DetailsCell.swift
//  GustoMenuTracker
//
//  Created by Leandro Diaz on 12/19/21.
//

import UIKit
import Anchorage

class DetailsCell: UITableViewCell {
    
    static let reuseID = "DetailsCell"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 2
        return label
    }()
    
    let detailsLabel = UILabel()
    let viewImage: UIImageView = {
        let viewimage = UIImageView()
        viewimage.layer.cornerRadius = 10
        viewimage.layer.borderWidth = 0.7
        viewimage.clipsToBounds = true
        viewimage.translatesAutoresizingMaskIntoConstraints = false
        return viewimage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with menu: Menu) {
        titleLabel.text = menu.itemTitle
        detailsLabel.text = menu.itemDescription
        viewImage.image = UIImage(named:menu.itemImage)
    }
    
    private func configure() {
        let labels = [ titleLabel, detailsLabel]
        for label in labels {
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            addSubview(label)
        }
        backgroundColor = CustomColors.CustomBeigeColor
        addSubview(viewImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        titleLabel.topAnchor == topAnchor + padding * 3
        titleLabel.leadingAnchor == leadingAnchor + padding
        titleLabel.trailingAnchor == trailingAnchor - padding
        
        viewImage.topAnchor == titleLabel.bottomAnchor + padding
        viewImage.horizontalAnchors == horizontalAnchors + padding
        viewImage.heightAnchor == heightAnchor / 3
        
        detailsLabel.topAnchor == viewImage.bottomAnchor + padding
        detailsLabel.leadingAnchor == leadingAnchor + padding
        detailsLabel.trailingAnchor == trailingAnchor - padding
        
    }
}
