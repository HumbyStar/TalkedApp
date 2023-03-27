//
//  ContentApresentationView.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 02/03/23.
//

import UIKit

class ContentView: UIView {
    
    lazy var ivCircle: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.layer.borderWidth = 10
        image.layer.borderColor = UIColor(red: 255/255, green: 206/255, blue: 129/255, alpha: 1).cgColor
        image.layer.cornerRadius = 150
        return image
    }()
    
    lazy var lbPresentation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = OrangeColors.textColor.color
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lbSubPresentation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = OrangeColors.textColor.color
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        [ivCircle, lbPresentation, lbSubPresentation].forEach({
            self.addSubview($0)
        })
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            ivCircle.widthAnchor.constraint(equalToConstant: 300),
            ivCircle.heightAnchor.constraint(equalToConstant: 300),
            ivCircle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ivCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            lbPresentation.topAnchor.constraint(equalTo: ivCircle.bottomAnchor,constant: 20),
            lbPresentation.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            lbPresentation.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40),
            
            lbSubPresentation.topAnchor.constraint(equalTo: lbPresentation.bottomAnchor, constant: 15),
            lbSubPresentation.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            lbSubPresentation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
            
        ])
    }
}

//Preciso dessa view dentro da Apresentation Screen, sendo apresentada como 3 views diferentes, agora preciso alimentar os dados dessa View, porém alimento aqui ou na apresentationView?

//Talvez seja interessante criar uma repository.

