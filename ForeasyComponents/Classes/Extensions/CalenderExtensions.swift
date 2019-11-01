//
//  CalenderExtensions.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/30.
//

public extension Calendar {
    func years(from: Int, to: Int) -> [Int] {
        guard from <= to else { return [] }
        return (from ... to).map { $0 }
    }
    
    func months() -> [Int] {
        return (1 ... 12).map { $0 }
    }
    
    func days(month: Int?, year: Int?) -> [Int] {
        let components = DateComponents(year: year, month: month, day: 1)
        let date = self.date(from: components) ?? Date()
        let days = range(of: .day, in: .month, for: date)?.count ?? 30
        return (1 ... days).map { $0 }
    }
    
    func hours() -> [Int] {
        return (0 ... 23).map { $0 }
    }
    
    func minutes() -> [Int] {
        return (0 ... 59).map { $0 }
    }
    
    func seconds() -> [Int] {
        return (0 ... 59).map { $0 }
    }
}
