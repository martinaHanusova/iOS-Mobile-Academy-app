//: [Etnetera Mobile Academy](https://mobileacademy.cz) (c) 2018
//: # 1. týden
//: ## DC: Vizitka
//:
//: [Vytvoř vizitku dle tohoto zadání](https://docs.google.com/document/d/17ypOGnBGPqt5Xb-FSkCsT5QXnCTwd5H1K9dCIQipYII/edit?usp=sharing)
import UIKit

class BusinessCardView: UIView {
    
    var content: BusinessCardContent? {
        didSet {
            setupContent()
        }
    }
    
    var slackClick: ClickHandler?
    var emailClick: ClickHandler?
    var phoneClick: ClickHandler?
    
    
    func setupContent() {
        guard let content = self.content else {
            return
        }
    
        slackClick = ClickHandler {
            print(content.slackUserId);
        }
        
        emailClick = ClickHandler {
            print(content.email);
        }
        
        phoneClick = ClickHandler {
            print(content.phone);
        }
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        
        let profileView = UIView()
        contentView.addSubview(profileView)
        profileView.layer.cornerRadius = 80
        profileView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        profileView.layer.borderWidth = 1
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80).isActive = true
        profileView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profileView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        profileView.heightAnchor.constraint(equalToConstant:160).isActive = true
        
        
        let profileImageView = UIImageView(image: UIImage(named: "Swift"))
        profileView.addSubview(profileImageView)
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileView.widthAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileView.heightAnchor).isActive = true
        
        
        let nameView = UILabel()
        contentView.addSubview(nameView)
        nameView.text = content.name
        nameView.numberOfLines = 0
        nameView.font = nameView.font.withSize(22)
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20).isActive = true
        nameView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        let buttonsView = UIView()
        contentView.addSubview(buttonsView)
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        buttonsView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 30).isActive = true
        buttonsView.widthAnchor.constraint(equalToConstant: 260).isActive = true

  
        let buttonSlack = UIButton()
        buttonSlack.addTarget(slackClick, action: #selector(ClickHandler.click), for: .touchUpInside)
        buttonSlack.setImage(UIImage(named: "ic-slack"), for: .normal)
        buttonsView.addSubview(buttonSlack)
        buttonSlack.translatesAutoresizingMaskIntoConstraints = false
        buttonSlack.leftAnchor.constraint(equalTo: buttonsView.leftAnchor).isActive = true
        buttonSlack.topAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
        
        // set height to buttonsview by first button
        buttonsView.heightAnchor.constraint(equalTo: buttonSlack.heightAnchor).isActive = true

        
        let buttonEmail = UIButton()
        buttonEmail.addTarget(emailClick, action: #selector(ClickHandler.click), for: .touchUpInside)
        buttonsView.addSubview(buttonEmail)
        buttonEmail.setImage(UIImage(named: "ic-email"), for: .normal)
        buttonEmail.translatesAutoresizingMaskIntoConstraints = false
        buttonEmail.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor).isActive = true
        buttonEmail.topAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
        
        
        let buttonPhone = UIButton()
        buttonPhone.addTarget(phoneClick, action: #selector(ClickHandler.click), for: .touchUpInside)
        buttonsView.addSubview(buttonPhone)
        buttonPhone.setImage(UIImage(named: "ic-phone"), for: .normal)
        buttonPhone.translatesAutoresizingMaskIntoConstraints = false
        buttonPhone.rightAnchor.constraint(equalTo: buttonsView.rightAnchor).isActive = true
        buttonPhone.topAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
        
        
        let labelSlack = UILabel()
        buttonsView.addSubview(labelSlack)
        labelSlack.text = "Slack"
        labelSlack.numberOfLines = 0
        labelSlack.font = nameView.font.withSize(12)
        labelSlack.translatesAutoresizingMaskIntoConstraints = false
        labelSlack.topAnchor.constraint(equalTo: buttonSlack.bottomAnchor, constant: 2).isActive = true
        labelSlack.centerXAnchor.constraint(equalTo: buttonSlack.centerXAnchor).isActive = true
        
        
        let labelEmail = UILabel()
        buttonsView.addSubview(labelEmail)
        labelEmail.text = "E-mail"
        labelEmail.numberOfLines = 0
        labelEmail.font = nameView.font.withSize(12)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.topAnchor.constraint(equalTo: buttonEmail.bottomAnchor, constant: 2).isActive = true
        labelEmail.centerXAnchor.constraint(equalTo: buttonEmail.centerXAnchor).isActive = true
        
        
        let labelPhone = UILabel()
        buttonsView.addSubview(labelPhone)
        labelPhone.text = "Telefon"
        labelPhone.numberOfLines = 0
        labelPhone.font = nameView.font.withSize(12)
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        labelPhone.topAnchor.constraint(equalTo: buttonEmail.bottomAnchor, constant: 2).isActive = true
        labelPhone.centerXAnchor.constraint(equalTo: buttonPhone.centerXAnchor).isActive = true
        
        
        let labelPosition = UILabel()
        contentView.addSubview(labelPosition)
        labelPosition.text = content.position
        labelPosition.numberOfLines = 0
        labelPosition.font = UIFont.boldSystemFont(ofSize: 16)
        labelPosition.translatesAutoresizingMaskIntoConstraints = false
        labelPosition.topAnchor.constraint(equalTo: labelSlack.bottomAnchor, constant: 25).isActive = true
        labelPosition.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        let borderView = UIView()
        let margin: CGFloat = 30
        contentView.addSubview(borderView)
        borderView.backgroundColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1)
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.topAnchor.constraint(equalTo: labelPosition.bottomAnchor, constant: 15).isActive = true
        borderView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        borderView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margin).isActive = true
        borderView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -margin).isActive = true
        
        
        let scoreView = UIView()
        contentView.addSubview(scoreView)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.topAnchor.constraint(equalTo: labelPosition.bottomAnchor, constant: 20).isActive = true
        scoreView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        scoreView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: margin).isActive = true
        scoreView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -margin).isActive = true
        
        /* problem s resize pri landScape
        let border = CALayer()
        border.backgroundColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
        border.frame = CGRect(x: 0, y: 0, width: bounds.width - margin * 2, height: 2)
        scoreView.layer.addSublayer(border)
        */
        

        var topView = scoreView
        for (name, value) in content.scores {
            let scoreLabelName = UILabel()
            scoreView.addSubview(scoreLabelName)
            scoreLabelName.font = nameView.font.withSize(12)
            scoreLabelName.text = name
            scoreLabelName.translatesAutoresizingMaskIntoConstraints = false
            scoreLabelName.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
            scoreLabelName.topAnchor.constraint(equalTo: topView.bottomAnchor, constant:35).isActive = true
            
            let scoreLabelValue = UILabel()
            scoreView.addSubview(scoreLabelValue)
            scoreLabelValue.text = String(value)
            scoreLabelValue.font = UIFont.boldSystemFont(ofSize: 12)
            scoreLabelValue.translatesAutoresizingMaskIntoConstraints = false
            scoreLabelValue.rightAnchor.constraint(equalTo: scoreView.rightAnchor).isActive = true
            scoreLabelValue.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
            
            topView = scoreLabelName

        }
            topView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

let container = Container()

let businessCardView = BusinessCardView()
container.content.addSubview(businessCardView)
businessCardView.frame = container.content.bounds
businessCardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

let content = BusinessCardContent(photoName: "placeholder", name: "Tomáš Kloubek", slackUserId: "3241", email: "tom@kloubek.cz", phone: "+420 123 432 654", position: "Swift ninja", scores: [("Pivní skóre", 12), ("Kafe skóre", 1), ("Čaj skóre", 3), ("Oběd skóre", 2)])
businessCardView.content = content
