//
//  IncomingTextfieldTableViewCell.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 13/03/23.
//

import UIKit

class IncomingTextfieldTableViewCell: UITableViewCell {
    
    static let identifier: String = "IncomingTextfieldTableViewCell"
    
    lazy var viewContactMessage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(white: 0, alpha: 0.06)
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
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
    
    func addSubview() {
        self.addSubview(viewContactMessage)
        self.viewContactMessage.addSubview(lbMessage)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.viewContactMessage.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            self.viewContactMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            self.viewContactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            self.lbMessage.leadingAnchor.constraint(equalTo: self.viewContactMessage.leadingAnchor, constant: 15),
            self.lbMessage.topAnchor.constraint(equalTo: self.viewContactMessage.topAnchor, constant: 15),
            self.lbMessage.trailingAnchor.constraint(equalTo: self.viewContactMessage.trailingAnchor, constant: -15),
            self.lbMessage.bottomAnchor.constraint(equalTo: self.viewContactMessage.bottomAnchor, constant: -15)
        ])
    }
    
    public func setupCell(message: Message?) {
        self.lbMessage.text = message?.texto ?? ""
    }
}
