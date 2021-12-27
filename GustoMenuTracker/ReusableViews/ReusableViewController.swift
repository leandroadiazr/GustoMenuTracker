//
//  ReusableViewController.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/20/21.
//

import UIKit
import Anchorage

class ReusableViewController: UIViewController {
    
    let titleLabel = CustomTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel = CustomBodyLabel(textAlignment: .center, fontSize: 14)
    
    var titleString: String? {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    var bodyText: String? {
        didSet {
            bodyLabel.text = bodyText
        }
    }
    
    var background: UIColor? {
        didSet {
            view.backgroundColor = background
        }
    }
    
//    init(titleString: String, bodyText: String, background: UIColor) {
//        super.init(nibName: nil, bundle: nil)
//        self.titleString = titleString
//        self.bodyText = bodyText
//        self.background = background
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

       setup()
    }
    
    
    func setupController(title: String, body: String, background: UIColor) {
        self.titleString = title
        self.bodyText = body
        self.background = background
    }
    
    
    private func setup() {
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.topAnchor == view.topAnchor + 100
        titleLabel.centerXAnchor == view.centerXAnchor
        
        bodyLabel.topAnchor == titleLabel.bottomAnchor + 100
        bodyLabel.centerXAnchor == view.centerXAnchor

    }
}
