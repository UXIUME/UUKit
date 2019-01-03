//
//  UIViewExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/4.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
    
    public convenience init(frame: CGRect = CGRect.zero, backgroundColor: UIColor = .clear) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
    }
    
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
}

@objc extension UIView {
    
    //MARK: - ———————————— Gradient Color ————————————
    /// 设置渐变背景色
    ///
    /// - Parameters:
    ///   - colors: 渐变颜色数组，需要和 locations 数组一一对应
    ///   - locations: 渐变色分段数组，数值为 0~1 之间的float值
    ///   - startPoint: 渐变色的起始位置
    ///   - endPoint: 渐变色的结束位置
    public func setGradientBG(colors: [UIColor] = [UIColorMake(0xCC0422), UIColorMake(0x7D0014)], locations: [NSNumber]? = nil, startPoint: CGPoint = CGPoint(x: 0.1, y: 0), endPoint: CGPoint = CGPoint(x: 0.9, y: 0)) {
        var cgColors = [CGColor]()
        for color: UIColor in colors {
            cgColors.append(color.cgColor)
        }
        if layer.isKind(of: CAGradientLayer.self) {
            (layer as! CAGradientLayer).colors = cgColors
            (layer as! CAGradientLayer).locations = locations
            (layer as! CAGradientLayer).startPoint = startPoint
            (layer as! CAGradientLayer).endPoint = endPoint
            (layer as! CAGradientLayer).frame = self.bounds
        }
    }
    
    //MARK: - ———————————— RoundedCorner ————————————
    /// 设置圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - borderWidth: 圆边宽度,默认为零
    ///   - borderColor: 圆边颜色，默认无色
    public func setRoundedCorner(_ radius: CGFloat, _ borderWidth: CGFloat = 0, _ borderColor: UIColor? = UIColor.clear) -> Void {
        layer.cornerRadius  = radius
        layer.borderWidth   = borderWidth
        layer.borderColor   = borderColor?.cgColor
        layer.masksToBounds = true
    }
    
    //MARK: - ———————————— ViewShadow ————————————
    /// 设置阴影
    ///
    /// - Parameters:
    ///   - color: 阴影的颜色
    ///   - offset: 阴影的偏移量
    ///   - radius: 圆角
    ///   - opacity: 不透明度
    public func setShadow(_ color: UIColor, _ offset: CGSize = CGSize(width: 4.0, height: 4.0), _ radius: CGFloat = 4.0, _ opacity: CGFloat = 0.8) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = Float(opacity)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
    
    
    
}

extension UIView {
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
}

