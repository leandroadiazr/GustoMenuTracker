//
//  UIViewController+Ext.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit
import Anchorage
fileprivate var containerView: UIView!

extension UIViewController {
    func customAlert(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle   = .overFullScreen
            alertVC.modalTransitionStyle     = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor == view.centerXAnchor
        activityIndicator.centerYAnchor == view.centerYAnchor
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async{
            containerView.removeFromSuperview()
            containerView = nil
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
