//
//  UILabelExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/5/16.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import UIKit

extension UILabel {
    
    public convenience init( frame: CGRect = CGRect.zero, text: String = "", textColor: UIColor = .black, font: UIFont = .systemFont(ofSize: 16), aligement: NSTextAlignment = .left, numOfLines: Int = 1) {
        self.init()
        self.font = font
        self.text = text
        self.frame = frame
        self.textColor = textColor
        self.textAlignment = aligement
        self.numberOfLines = numOfLines
    }
    
    public static func initForTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }
    
    public static func initForDescription() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }
    
}
