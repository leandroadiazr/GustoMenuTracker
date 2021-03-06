//
//  CustomButton.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String, backgroundImage: UIImage?) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setImage(backgroundImage, for: .normal)
    }
    
    private func configure(){
        layer.cornerRadius       = 5
        setTitleColor(.white, for: .normal)
        titleLabel?.font         = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
