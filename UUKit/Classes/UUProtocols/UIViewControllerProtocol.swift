//
//  UIViewControllerProtocol.swift
//  Pods
//
//  Created by uxiu.me on 2019/1/16.
//

import UIKit

public protocol UUViewControllerProtocol: NSObjectProtocol {
    
    
    
}

protocol UISearchBarProtocol {
    
}

protocol UIViewControllerProtocol: NSObjectProtocol {
    
//    var isStatusBarHidden: Bool {get set}
//    var statusBarStyle: UIStatusBarStyle {get set}
//    
//    var isNavigationBarHidden: Bool {get set}
//    
//    var navigationLeftItem: UIView? {get set}
//    var navigationRightItem: UIView? {get set}
//    
//    func setStatusBarStyle(_ style: UIStatusBarStyle)
    
}

extension UIViewControllerProtocol where Self: UIViewController {
    
//    var isStatusBarHidden: Bool {
//        get {
//            return self.prefersStatusBarHidden
//        }
//        set {
//            isStatusBarHidden = newValue
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
//    }
//    
//    var prefersStatusBarHidden: Bool {
//        return isStatusBarHidden
//    }
    
}

