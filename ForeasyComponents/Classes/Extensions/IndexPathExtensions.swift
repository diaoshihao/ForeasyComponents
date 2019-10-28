//
//  IndexPathExtensions.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/23.
//

public extension IndexPath {
    init(row: Int, component: Int) {
        self.init(row: row, section: component)
        self.item = row
        self.section = component
    }
    
    var component: Int {
        return section
    }
}
