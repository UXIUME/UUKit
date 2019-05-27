//
//  UIColorExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/4.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import UIKit


extension UIColor {
    
    /// UIColor(r: 95, g: 199, b: 220)，透明度（0 ~ 1）
    public convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// UIColor(hex: 0x5fc7dc)，透明度（0 ~ 1）
    public convenience init(hexInt: UInt64, alpha: CGFloat = 1.0) {
        let r = CGFloat((hexInt & 0xff0000) >> 16)
        let g = CGFloat((hexInt & 0x00ff00) >> 8)
        let b = CGFloat( hexInt & 0x0000ff)
        self.init(r, g, b, a: alpha)
    }
    
    public convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let formattedHEX = hexString
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
            .replacingOccurrences(of: "#" , with: "")
        let scanner = Scanner(string: "0x\(formattedHEX)")
        scanner.scanLocation = 0
        var hexInt: UInt64 = 0
        scanner.scanHexInt64(&hexInt)
        self.init(hexInt: hexInt, alpha: alpha)
    }
    
    /// 获取颜色对应的16进制数值
    public var toHexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "0x%02X%02X%02X", Int(r * 0xff), Int(g * 0xff), Int(b * 0xff))
    }
    
    /// 随机色 UIColor.random
    public static var random: UIColor {
        return UIColor(CGFloat(arc4random_uniform(256)),
                       CGFloat(arc4random_uniform(256)),
                       CGFloat(arc4random_uniform(256)))
    }
    
}
