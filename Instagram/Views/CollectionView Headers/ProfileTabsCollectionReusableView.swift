//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Peter Emil on 13/07/2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate : AnyObject {
    func didTapGridButtonTab()
    func didTaptaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    
    struct Constants {
        static let padding: CGFloat = 6
        
    }
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(gridButton)
        addSubview(taggedButton)
        
        gridButton.addTarget(self, action: #selector(didTapGridButtonTab), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTaptaggedButtonTab), for: .touchUpInside)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height-(Constants.padding*2)
        let gridButtonX = (width/2-size)/2
        
        gridButton.frame = CGRect(x: gridButtonX, y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: gridButtonX + (width/2), y: Constants.padding, width: size, height: size)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapGridButtonTab() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTaptaggedButtonTab() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        
        delegate?.didTaptaggedButtonTab()

    }
}
