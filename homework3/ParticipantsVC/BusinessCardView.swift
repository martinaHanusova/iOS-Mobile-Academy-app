//
//  BusinessCardView.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit

class BusinessCardView: UIScrollView {
    
    var content: BusinessCardContent? {
        didSet {
            setupContent()
        }
    }
    
    lazy var slackClick: ClickHandler = createSlackClickHandler()
    lazy var emailClick: ClickHandler = createEmailClickHandler()
    lazy var phoneClick: ClickHandler = createPhoneClickHandler()
    
    lazy var contentView = createContentView()
    lazy var profileImageView = createProfileImageView()
    lazy var nameView = createNameView()
    lazy var contactStackView = createContactStactView()
    lazy var positionLabel = createPositionLabel()
    lazy var borderView = createBorderView()
    
    var scoreViews: [ScoreView] = []
    
    func setupContent() {
        guard let content = self.content else {
            return
        }
        profileImageView.image = UIImage(named: content.photoName)
        nameView.text = content.name
        positionLabel.text = content.position
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scoreViews.forEach { (scoreView) in
            scoreView.removeFromSuperview()
        }
        scoreViews = []
        // ScoreView
        for score in content.scores {
            let scoreView = ScoreView()
            scoreView.data = score
            scoreViews.append(scoreView)
            scoreView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addArrangedSubview(scoreView)
            scoreView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
            contentView.setCustomSpacing(50, after: scoreView)
        }
    }
    
    func createSlackClickHandler() -> ClickHandler {
        return ClickHandler {
            print(self.content!.slackUserId)
        }
    }
    
    func createEmailClickHandler() -> ClickHandler {
        return ClickHandler {
            print(self.content!.email)
        }
    }
    
    func createPhoneClickHandler() -> ClickHandler {
        return ClickHandler {
            print(self.content!.phone)
        }
    }
    
    func createContentView() -> UIStackView {
        let contentView = UIStackView()
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        contentView.axis = .vertical
        contentView.alignment = .center
        contentView.distribution = .fill
        contentView.spacing = 30
        contentView.addArrangedSubview(profileImageView)
        contentView.addArrangedSubview(nameView)
        contentView.addArrangedSubview(contactStackView)
        contentView.addArrangedSubview(positionLabel)
        contentView.setCustomSpacing(20, after: positionLabel)
        contentView.addArrangedSubview(borderView)
        borderView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        contentView.setCustomSpacing(20, after: borderView)
        return contentView
    }
    
    func createProfileImageView() -> UIImageView {
        let profileImageView = UIImageView()
        profileImageView.layer.cornerRadius = 80
        profileImageView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 1
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        profileImageView.contentMode = .scaleAspectFit
        return profileImageView
    }
    
    func createNameView() -> UILabel {
        let nameView = UILabel()
        nameView.numberOfLines = 0
        nameView.font = nameView.font.withSize(22)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        return nameView
    }
    
    func createContactStactView() -> UIStackView {
        let buttonSlack = ContactUIButton(imageName: "ic-slack", title: "Slack", clickHandler: slackClick)
        
        let buttonEmail = ContactUIButton(imageName: "ic-email", title: "Email", clickHandler: emailClick)
        
        let buttonPhone = ContactUIButton(imageName: "ic-phone", title: "Phone", clickHandler: phoneClick)
        let contactStackView = UIStackView(arrangedSubviews: [buttonSlack, buttonEmail, buttonPhone])
        contactStackView.alignment = .center
        contactStackView.axis = .horizontal
        contactStackView.spacing = 10
        return contactStackView
    }
    
    func createPositionLabel() -> UILabel {
        let labelPosition = UILabel()
        
        labelPosition.numberOfLines = 0
        labelPosition.font = UIFont.boldSystemFont(ofSize: 16)
        return labelPosition
    }
    
    func createBorderView() -> UIView {
        let borderView = UIView()
        borderView.backgroundColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return borderView
    }
}

public class ScoreView: UIView {
    public var data: ScoreType? {
        didSet {
            setupContent()
        }
    }
    
    func setupContent() {
        guard let data = self.data else {
            return
        }
        
        let nameLabel = UILabel()
        addSubview(nameLabel)
        nameLabel.font = UIFont(name:"Helvetica", size: 12)
        nameLabel.text = data.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
        let valueLabel = UILabel()
        addSubview(valueLabel)
        valueLabel.text = String(data.value)
        valueLabel.font = UIFont(name:"Helvetica", size: 12)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        
    }
}


public class ContactUIButton: UIButton {
    
    public convenience init(imageName: String, title: String, clickHandler: ClickHandler) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name:"Helvetica", size: 14)
        addTarget(clickHandler, action: #selector(ClickHandler.click), for: .touchUpInside)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.centerVertically()
    }
    
    public func centerVertically(padding: CGFloat = 3.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}


