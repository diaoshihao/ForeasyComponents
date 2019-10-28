//
//  TableViewCell.swift
//  ForeasyComponents_Example
//
//  Created by 刁世浩 on 2019/10/18.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class FCTextTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    var insets: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0) {
        didSet {
            titleLabel.snp.remakeConstraints { (make) in
                make.edges.equalTo(insets)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(insets)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
