//
//  OutgoingTextTableViewCell.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 13/03/23.
//

import UIKit

class OutgoingTextfieldTableViewCell: UITableViewCell {
    
    static let identifier: String = "OutgoingTextfieldTableViewCell"
    
    lazy var viewMyMessage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = OrangeColors.textColor.color
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var lbMessage: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.textColor = .red        // Editar palheta de cor
        lb.font = UIFont(name: CustomFont.montSerrat, size: 14)
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        self.addSubview(viewMyMessage)
        self.viewMyMessage.addSubview(lbMessage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.viewMyMessage.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            self.viewMyMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            self.viewMyMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),

            
            self.lbMessage.leadingAnchor.constraint(equalTo: self.viewMyMessage.leadingAnchor, constant: 15),
            self.lbMessage.topAnchor.constraint(equalTo: self.viewMyMessage.topAnchor, constant: 15),
            self.lbMessage.trailingAnchor.constraint(equalTo: self.viewMyMessage.trailingAnchor, constant: -15),
            self.lbMessage.bottomAnchor.constraint(equalTo: self.viewMyMessage.bottomAnchor, constant: -15)
        ])
    }
    
    public func setupCell(message: Message?) {
        self.lbMessage.text = message?.texto ?? ""
    }
}

