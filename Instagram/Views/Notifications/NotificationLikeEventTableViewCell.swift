//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Peter Emil on 22/07/2022.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@joe liked your photo"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(ProfileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ProfileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: height-6)
        ProfileImageView.layer.cornerRadius = ProfileImageView.height/2
        
        let size: CGFloat = contentView.height-4
        postButton.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
        
        label.frame = CGRect(x: ProfileImageView.right+5,
                             y: 0,
                             width: contentView.width-size-ProfileImageView.width-16,
                             height: contentView.height)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ProfileImageView.image = nil
        label.text = nil
        postButton.setBackgroundImage(nil, for: .normal)
        
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        
        delegate?.didTapRelatedPostButton(model: model)

    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case.like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
            break
        case.follow:
            break
        }
        
        label.text = model.text
        ProfileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
}
