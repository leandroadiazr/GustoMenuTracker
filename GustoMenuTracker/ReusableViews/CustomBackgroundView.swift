//
//  CustomBackgroundView.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit
import Anchorage

class CustomBackgroundView: UIView {
    fileprivate let txt = "Having issues tracking what's on the menu for today?... I'm pretty sure this simple App can help you with that"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel = CustomTitleLabel(textAlignment: .left, fontSize: 28)
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 4
        label.textColor = .white
        return label
    }()
    
    var label: String? {
        didSet {
            titleLabel.text = label
        }
    }
    
    var background: UIColor? {
        didSet {
            imageView.backgroundColor = backgroundColor
        }
    }
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(imageView)
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.numberOfLines = 2
        addSubview(detailsLabel)
        detailsLabel.text = txt
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.edgeAnchors == edgeAnchors
        titleLabel.topAnchor == topAnchor + 50
        titleLabel.leadingAnchor == leadingAnchor + 20
        titleLabel.trailingAnchor == centerXAnchor - 5
        
        detailsLabel.topAnchor == topAnchor + 100
        detailsLabel.leadingAnchor == centerXAnchor
        detailsLabel.trailingAnchor == trailingAnchor - 10
    }
    
    
}
