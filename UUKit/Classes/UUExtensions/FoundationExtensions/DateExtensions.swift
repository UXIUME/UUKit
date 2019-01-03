//
//  DateExtensions.swift
//  Dynasty.dajiujiao
//
//  Created by uxiu.me on 2018/6/4.
//  Copyright © 2018年 HangZhouFaDaiGuoJiMaoYi Co. Ltd. All rights reserved.
//

import Foundation

extension Date {
    
    public var weekday: String {
        let weekdays = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"]
        let index = Calendar.current.component(.weekday, from: self) - 1
        return weekdays[index]
    }
    
    public static func setup(_ dateString: String, formaterString str: String) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = str
        guard let date = dateFormater.date(from: dateString) else {
            print("字符串转时间失败！")
            return nil
        }
        return date
    }
    
}
