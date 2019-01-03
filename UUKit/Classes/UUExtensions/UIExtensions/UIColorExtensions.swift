//
//  UIColorExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/4.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import UIKit


/// 颜色缓存器，同种颜色被缓存到内存中
private var ColorCacheMap = [String : UIColor]()

/// 根据RGB值生成一个颜色实例
///
/// - Parameters:
///   - red: 0 ~ 255.0
///   - green: 0 ~ 255.0
///   - blue: 0 ~ 255.0
///   - alpha: 0 ~ 1.0
/// - Returns: UIColor实例
public func UIColorMake(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

/// 根据16进制HEX数值生成一个颜色实例
///
/// - Parameters:
///   - hexInt: 16进制数值 例. 0xFFFFFF
///   - alpha: 颜色透明度
/// - Returns: UIColor实例
public func UIColorMake(_ hexInt: Int, _ alpha: CGFloat = 1.0) -> UIColor {
    let key = "\(hexInt)"+String(format:"_%.6f",alpha)
    if let color = ColorCacheMap[key] { return color }
    let r = CGFloat((hexInt & 0xFF0000) >> 16) / 255.0
    let g = CGFloat((hexInt & 0x00FF00) >> 8)  / 255.0
    let b = CGFloat((hexInt & 0x0000FF) >> 0)  / 255.0
    let color = UIColor(red: r, green: g, blue: b, alpha: alpha)
    ColorCacheMap[key] = color
    return color
}

/// 根据16进制HEX字符串生成一个颜色实例
///
/// - Parameters:
///   - hexString: 16进制颜色值字符串 例如: "0xFFFFFF" 、 "FFFF00" 、 "#FFFFFF"
///   - alpha: 颜色透明度
/// - Returns: UIColor实例
public func UIColorMake(_ hexString: String, _ alpha: CGFloat = 1.0) -> UIColor {
    let formattedHEX = hexString
        .replacingOccurrences(of: "0x", with: "")
        .replacingOccurrences(of: "0X", with: "")
        .replacingOccurrences(of: "#" , with: "")
    //let hex = Int(formattedHEX, radix: 16)!
    let hexInt = strtol(formattedHEX.cString(using: .utf8), nil, 16)
    return UIColorMake(hexInt)
}


// MARK: - UIColorExtens
extension UIColor {
    
    /// UIColor(r: 95, g: 199, b: 220)，透明度（0 ~ 1）
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// UIColor(hex: 0x5fc7dc)，透明度（0 ~ 1）
    public convenience init(hex:Int, alpha: CGFloat = 1.0) {
        self.init(r:CGFloat((hex >> 16) & 0xff), g:CGFloat((hex >> 8) & 0xff), b:CGFloat(hex & 0xff), alpha: alpha)
    }
    
    /// 随机色 UIColor.random
    public static var random: UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
    /// 获取颜色对应的16进制数值
    public var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "0x%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    public convenience init(_ hexString: String, _ alpha: CGFloat = 1.0) {
        let formattedHEX = hexString
            .replacingOccurrences(of: "0x", with: "")
            .replacingOccurrences(of: "0X", with: "")
            .replacingOccurrences(of: "#" , with: "")
        let scanner = Scanner(string: "0x\(formattedHEX)")
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = (rgbValue & 0xff) >> 0
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
    
}
