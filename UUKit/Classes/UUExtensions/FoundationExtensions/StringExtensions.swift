//
//  StringExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/8.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import UIKit

extension String {
    /// 字符串为 nil、" "、""、"\n" 返回true
    public var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}


// MARK: - Size
extension String {
    
    public func size(with font: UIFont, drawingSize: CGSize, mode: NSLineBreakMode) -> CGSize {
        var attr = [NSAttributedString.Key:Any]()
        attr[NSAttributedString.Key.font] = font
        if mode != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = mode
            attr[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        let options = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue)
        return NSString(string: self).boundingRect(with: drawingSize, options: options , attributes: attr, context: nil).size
    }
    
    /// 根据文本显示的高度计算宽度
    ///
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - height: 文本要显示的高度
    ///   - options: 文本显示的格式，有没有行间距等等
    /// - Returns: 返回文本的宽度
    public func width(fontSize: CGFloat, height: CGFloat = 15, options: NSStringDrawingOptions = .usesLineFragmentOrigin) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    
    /// 根据文本显示的宽度，计算文本的高度，并使高度不大于设置最大值
    ///
    /// - Parameters:
    ///   - fontSize: 文字大小
    ///   - width: 文本显示的宽度
    ///   - limitedHeight: 文本限制高度，大于此高度则返回此高度
    ///   - options: 文本显示的格式，有没有行间距等等
    /// - Returns: 返回文本高度
    public func height(fontSize: CGFloat, width: CGFloat, limitedHeight: CGFloat = CGFloat(MAXFLOAT), options: NSStringDrawingOptions = .usesLineFragmentOrigin) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height) > limitedHeight ? limitedHeight : ceil(rect.height)
    }
    
}

extension String {
    
    /// 是否是有效的网址
    public var isValidURL: Bool {
        let pattern = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,6})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,6})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(((http[s]{0,1}|ftp)://|)((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的手机号或电话号码
    public var isValidPhone: Bool {
        let pattern = "\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[3578]+\\d{9}|[+]861+[3578]+\\d{9}|861+[3578]+\\d{9}|1+[3578]+\\d{1}-\\d{4}-\\d{4}|\\d{8}|\\d{7}|400-\\d{3}-\\d{4}|400-\\d{4}-\\d{3}"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    /// 是否是有效的邮箱
    public var isValidEmail: Bool {
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,6}"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.count)).count ?? 0 > 0
    }
    
    
}

