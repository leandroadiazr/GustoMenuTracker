//
//  CartTableViewCell.swift
//  GustoMenuTracker
//
//  Created by Leandro Diaz on 12/19/21.
//

import UIKit
import Anchorage

class CartTableViewCell: UITableViewCell {
    static let reuseID = "CartTableViewCell"
    
    struct Layout {
        static let cornerRadius = CGFloat(16)
        static let edgeInsets = CGFloat(15)
    }
    
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
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.layer.cornerRadius = Layout.cornerRadius
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let removeButton = CustomButton(backgroundColor: .clear, title: "", backgroundImage: UIImage(systemName: "trash"))
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureViews()
    }
    
    private func configureViews() {
        addSubview(viewImage)
        addSubview(titleLabel)
        addSubview(detailsLabel)
        addSubview(removeButton)
        setupConstraints()
    }
    
    func configureCell(with menu: Menu) {
        viewImage.image = UIImage(named: menu.itemImage)
        titleLabel.text = menu.itemTitle
        detailsLabel.text = menu.itemDescription
    }
    
    private func setupConstraints() {
        let padding = CGFloat(10)
        viewImage.centerYAnchor == centerYAnchor
        viewImage.leadingAnchor == leadingAnchor + 10
        viewImage.widthAnchor == 70
        viewImage.heightAnchor == 70
        
        titleLabel.topAnchor == topAnchor + padding
        titleLabel.leadingAnchor == viewImage.trailingAnchor + padding
        
        detailsLabel.topAnchor == titleLabel.bottomAnchor
        detailsLabel.leadingAnchor == viewImage.trailingAnchor + padding
        detailsLabel.trailingAnchor == removeButton.leadingAnchor + padding
        detailsLabel.bottomAnchor ==  bottomAnchor - padding
        
        removeButton.centerYAnchor == centerYAnchor
        removeButton.trailingAnchor == trailingAnchor - padding
        removeButton.widthAnchor == 20
        removeButton.heightAnchor == 20
    }
}
