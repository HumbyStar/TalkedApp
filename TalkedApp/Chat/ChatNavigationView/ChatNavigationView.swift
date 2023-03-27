//
//  ChatNavigationView.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 10/03/23.
//

import UIKit

class ChatNavigationView: UIView {
    
    var controller: ChatViewController? {
        didSet {
            self.btBack.addTarget(controller, action: #selector(ChatViewController.tapToBtBack), for: .touchUpInside)
        }
    }
    
    lazy var navBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = OrangeColors.textColor.color
        view.layer.cornerRadius = 35
        view.layer.masksToBounds = false
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var lbSearch: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Digite aqui"
        lb.font = UIFont(name: CustomFont.montSerrat, size: 16)
        lb.textColor = OrangeColors.lightOrange.color
        return lb
    }()
    
    lazy var btSearch: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "Search")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = OrangeColors.lightOrange.color
        return bt
    }()
    
    lazy var btBack: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
        bt.tintColor = OrangeColors.lightOrange.color
        return bt
    }()
    
    lazy var ivCustom: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 26
        iv.image = UIImage(systemName: "person.fill")
        iv.tintColor = OrangeColors.lightOrange.color
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubview() {
        self.addSubview(navBackgroundView)
        self.navBackgroundView.addSubview(navBar)
        self.navBar.addSubview(ivCustom)
        self.navBar.addSubview(searchBar)
        self.navBar.addSubview(btBack)
        self.searchBar.addSubview(lbSearch)
        self.searchBar.addSubview(btSearch)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.btBack.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
            self.btBack.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.btBack.heightAnchor.constraint(equalToConstant: 30),
            self.btBack.widthAnchor.constraint(equalToConstant: 30),
            
            self.ivCustom.leadingAnchor.constraint(equalTo: self.btBack.trailingAnchor, constant: 20),
            self.ivCustom.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.ivCustom.heightAnchor.constraint(equalToConstant: 55),
            self.ivCustom.widthAnchor.constraint(equalToConstant: 55),
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.ivCustom.trailingAnchor, constant: 20),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.lbSearch.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            self.lbSearch.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.btSearch.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.btSearch.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.btSearch.heightAnchor.constraint(equalToConstant: 20),
            self.btSearch.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
