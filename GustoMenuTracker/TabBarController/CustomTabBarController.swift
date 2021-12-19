//
//  CustomTabBarController.swift
//  GustoMenuTracker
//
//  Created by LeandroDiaz on 12/19/21.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createTabBar()
    }
    
    fileprivate func createTabBar() {
        UITabBar.appearance().tintColor = CustomColors.CustomGreenColor
        UITabBar.setTransparency()
        self.viewControllers = [createMenuViewController(), createCartViewController()]
    }
    
    func createMenuViewController() -> UINavigationController{
        let homeNavCon        = MenuViewController()
        homeNavCon.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "menucard"), selectedImage: UIImage(systemName: "menucard.fill"))
        tabBarItem.tag = 0
        
        return UINavigationController(rootViewController: homeNavCon)
    }

    func createCartViewController() -> UINavigationController{
        let cartNavCon        = CartViewController()
        cartNavCon.title      = "Cart"
        cartNavCon.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        tabBarItem.tag = 1
        
        return UINavigationController(rootViewController: cartNavCon)
    }
    
}

extension UITabBar {
    static func setTransparency() {
        let transparent = UIImage()
        
        UITabBar.appearance().backgroundImage = transparent
        UITabBar.appearance().backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.8)
    }
}
