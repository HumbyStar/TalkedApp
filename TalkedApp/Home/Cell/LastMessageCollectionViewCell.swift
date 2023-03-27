//
//  LastMessageCollectionViewCell.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import UIKit

class LastMessageCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "LastMessageCollectionViewCell"
    
    lazy var ivIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = false
        iv.image = UIImage(systemName: "person.badge.plus")
        iv.tintColor = OrangeColors.lightOrange.color
        return iv
    }()
    
    lazy var lbUsername: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Adicionar novo contato"
        lb.font = UIFont(name: CustomFont.montSerrat, size: 16)
        lb.textColor = OrangeColors.darkOrange.color
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
    
    private func addSubview() {
        self.addSubview(ivIcon)
        self.addSubview(lbUsername)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.ivIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.ivIcon.widthAnchor.constraint(equalToConstant: 55),
            self.ivIcon.heightAnchor.constraint(equalToConstant: 55),
            
            self.lbUsername.leadingAnchor.constraint(equalTo: self.ivIcon.trailingAnchor, constant: 15),
            self.lbUsername.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.lbUsername.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
