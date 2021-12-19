//
//  UIViewController+Ext.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit

extension UIViewController {
    func customAlert(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle   = .overFullScreen
            alertVC.modalTransitionStyle     = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

extension UIView {
    func addCustomShadow(view: UIView) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 1
        layer.shouldRasterize = false
    }
}
