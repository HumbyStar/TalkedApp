//
//  DetailMessageCollectionViewCell.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 09/03/23.
//

import UIKit

class DetailMessageCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailMessageCollectionViewCell"
    
    lazy var ivIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 26
        iv.image = UIImage(systemName: "person")
        iv.tintColor = OrangeColors.lightOrange.color
        return iv
    }()
    
    lazy var lbUsername: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 2
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViewContact(contact: Contact) {
        self.setUserName(username: contact.name ?? "")
    }
    
    public func setupConversation(conversation: Conversation) {
        self.setUserNameAttributedText(conversation: conversation)
    }
    
    private func setUserName(username:String) {
        let attributedtext = NSMutableAttributedString(string: username, attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.montSerrat, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.lbUsername.attributedText = attributedtext
//        self.lbUsername.text = username
//        self.lbUsername.font = UIFont(name: CustomFont.montSerrat, size: 16)
//        self.lbUsername.textColor = .darkGray
    }
    
    private func setUserNameAttributedText(conversation: Conversation) {
        let attributedtext = NSMutableAttributedString(string: conversation.nome ?? "", attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.montSerrat, size: 16) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        attributedtext.append(NSAttributedString(string: "\n\(conversation.ultimaMensagem ?? "")", attributes: [NSAttributedString.Key.font: UIFont(name: CustomFont.montSerrat, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        self.lbUsername.attributedText = attributedtext
        
    }
    
    private func addSubview() {
        contentView.addSubview(ivIcon)
        contentView.addSubview(lbUsername)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.ivIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.ivIcon.widthAnchor.constraint(equalToConstant: 55),
            self.ivIcon.heightAnchor.constraint(equalToConstant: 55),
            
            self.lbUsername.leadingAnchor.constraint(equalTo: self.ivIcon.trailingAnchor, constant: 15),
            self.lbUsername.centerYAnchor.constraint(equalTo: self.ivIcon.centerYAnchor),
            self.lbUsername.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
