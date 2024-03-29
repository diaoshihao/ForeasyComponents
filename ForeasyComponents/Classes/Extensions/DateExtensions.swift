//
//  DateExtensions.swift
//  SwiftyExtensions
//
//  Created by 刁世浩 on 2019/9/25.
//  Copyright © 2019 刁世浩. All rights reserved.
//

import Foundation

public extension Date {
    
    /// 时间格式化字符串
    ///
    /// - Parameter format: 时间格式
    /// - Returns: 格式化后的字符串
    func string(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

public extension Date {
    enum Component {
        case year
        case month
        case day
        case hour
        case minute
        case second
    }
    
    func value(for component: Component) -> Int {
        switch component {
        case .year: return self.year
        case .month: return self.month
        case .day: return self.day
        case .hour: return self.hour
        case .minute: return self.minute
        case .second: return self.second
        }
    }
}

public extension Date {
    
    static func current(type: Calendar.Component) -> Int {
        let calender = Calendar.current
        return calender.component(type, from: Date())
    }
    
    var year: Int {
        let calender = Calendar.current
        return calender.component(.year, from: self)
    }
    
    var month: Int {
        let calender = Calendar.current
        return calender.component(.month, from: self)
    }
    
    var day: Int {
        let calender = Calendar.current
        return calender.component(.day, from: self)
    }
    
    var hour: Int {
        let calender = Calendar.current
        return calender.component(.hour, from: self)
    }
    
    var minute: Int {
        let calender = Calendar.current
        return calender.component(.minute, from: self)
    }
    
    var second: Int {
        let calender = Calendar.current
        return calender.component(.second, from: self)
    }
    
    var days: Int {
        let calender = Calendar.current
        return calender.range(of: .day, in: .month, for: self)?.count ?? 30
    }
}
