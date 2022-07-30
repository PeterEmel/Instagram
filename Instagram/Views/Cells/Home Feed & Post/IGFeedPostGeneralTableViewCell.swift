//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by Peter Emil on 11/07/2022.
//

import UIKit

class IGFeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemOrange
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
