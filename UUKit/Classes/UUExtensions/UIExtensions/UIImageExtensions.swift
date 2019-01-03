//
//  UIImageExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/4/23.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import UIKit

@objc public extension UIImage {
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - imgName: <#imgName description#>
    ///   - bundleName: <#bundleName description#>
    /// - Returns: <#return value description#>
    public static func `init`(_ imgName: String, inBundle bundleName: String) -> UIImage? {
//        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
//        NSString *imgPath= [bundlePath stringByAppendingPathComponent:imgName];
//        UIImage *image=[UIImage imageWithContentsOfFile:imgPath];
//        return image;
        let tmpBundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        guard let bundlePath = tmpBundlePath else {
            return nil
        }
        let tmpBundle = Bundle.init(path: bundlePath)
        guard let bundle = tmpBundle else {
            return nil
        }
        let tmpImagePath = bundle.path(forResource: imgName, ofType: "png")
        guard let imagePath = tmpImagePath else {
            return nil
        }
        let tmpImage = UIImage(contentsOfFile: imagePath)?.withRenderingMode(.alwaysOriginal)
        guard let image = tmpImage else {
            return nil
        }
        return image
    }
    
    
    
    /// 根据颜色创建一张纯色的图片
    ///
    /// - Parameter color: 颜色值
    /// - Returns: 返回一个UIImage实例
    public static func `init`(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
}
