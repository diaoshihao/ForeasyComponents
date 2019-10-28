//
//  CollectionViewCell.swift
//  ForeasyComponents
//
//  Created by 刁世浩 on 2019/10/15.
//

open class FCTextCollectionViewCell: UICollectionViewCell {
    public let textLabel = UILabel()
    public var insets: UIEdgeInsets = .zero {
        didSet {
            textLabel.snp.remakeConstraints { (make) in
                make.edges.equalTo(insets)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(insets)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class FCImageCollectionViewCell: UICollectionViewCell {
    public let imageView = UIImageView()
    public var insets: UIEdgeInsets = .zero {
        didSet {
            imageView.snp.remakeConstraints { (make) in
                make.edges.equalTo(insets)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(insets)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

