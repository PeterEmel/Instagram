//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Peter Emil on 22/07/2022.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let ProfileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.text = "@kany started following you."
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubview(ProfileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
        configureForFollow()
        
        selectionStyle = .none

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ProfileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: height-6)
        ProfileImageView.layer.cornerRadius = ProfileImageView.height/2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 44
        followButton.frame = CGRect(x: contentView.width-5-size, y: (contentView.height-buttonHeight)/2, width: size, height: buttonHeight)
        
        label.frame = CGRect(x: ProfileImageView.right+5,
                             y: 0,
                             width: contentView.width-size-ProfileImageView.width-16,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ProfileImageView.image = nil
        label.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case.like(_):
            break
        case.follow(let state):
            switch state {
            case .following:
                configureForFollow()
            case .not_Following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
            break
        }
        
        label.text = model.text
        ProfileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
}
