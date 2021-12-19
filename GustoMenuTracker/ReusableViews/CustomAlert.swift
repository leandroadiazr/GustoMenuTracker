//
//  CustomAlert.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit

class AlertViewController: UIViewController {
    let containerview = CustomAlertContainerView()
    let titleLabel = CustomTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = CustomBodyLabel(textAlignment: .center, fontSize: 12)
    let actionButton = CustomButton(backgroundColor: .systemBlue, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = alertTitle
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
        callConstraints()
    }
    
    
    func configureContainerView(){
        view.addSubview(containerview)
    }

    func configureTitleLabel(){
        containerview.addSubview(titleLabel)
        titleLabel.font =  .preferredFont(forTextStyle: .largeTitle)
        titleLabel.text = alertTitle ?? ""
    }
 
    func configureActionButton(){
        containerview.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    
    func configureMessageLabel(){
        containerview.addSubview(messageLabel)
        messageLabel.font = .preferredFont(forTextStyle: .body)
        messageLabel.text = message ?? ""
        messageLabel.numberOfLines = 4
    }
  
    @objc func dismissVC(){
        dismiss(animated: true)
    }

    private func callConstraints(){
        
        //Container View Constraints
        NSLayoutConstraint.activate([
            containerview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerview.widthAnchor.constraint(equalToConstant: 320),
            containerview.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerview.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerview.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerview.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        // Action Button Constraints
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerview.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerview.leadingAnchor, constant: padding * 2),
            actionButton.trailingAnchor.constraint(equalTo: containerview.trailingAnchor, constant: -padding * 2),
            actionButton.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        //Message Label Constraints
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerview.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerview.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -8)
        ])
    }
}


class CustomAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor           = .systemBackground
        layer.cornerRadius        = 16
        layer.borderColor         = UIColor.white.cgColor
        layer.borderWidth         = 2
//        layer.opacity             = 0.80
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
