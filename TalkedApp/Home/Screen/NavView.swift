//
//  NavView.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 05/03/23.
//

import UIKit

enum TypeButton {
    case conversation
    case contact
}

protocol NavViewProtocol: AnyObject {
    func screenTypeButton(type: TypeButton)
}

class NavView: UIView {
    
    private weak var delegate: NavViewProtocol?
    
    lazy var navBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.masksToBounds = false
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
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
        view.backgroundColor = OrangeColors.textColor.color
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
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    lazy var btConversation: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = OrangeColors.darkOrange.color
        bt.addTarget(self, action: #selector(tapInConversationButton), for: .touchUpInside)
        return bt
    }()
    
    lazy var btContact: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = OrangeColors.lightOrange.color
        bt.addTarget(self, action: #selector(tapInContactButton), for: .touchUpInside)
        return bt
    }()
    
    public func navViewDelegate(delegate: NavViewProtocol) {
        self.delegate = delegate
    }
    
    @objc func tapInConversationButton() {
        self.btConversation.tintColor = OrangeColors.lightOrange.color
        self.btContact.tintColor = OrangeColors.darkOrange.color
        self.delegate?.screenTypeButton(type: .conversation)
    }
    
    @objc func tapInContactButton() {
        self.btConversation.tintColor = OrangeColors.darkOrange.color
        self.btContact.tintColor = OrangeColors.lightOrange.color
        self.delegate?.screenTypeButton(type: .contact)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(self.navBackgroundView)
        self.navBackgroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.searchBar)
        self.navBar.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.btConversation)
        self.stackView.addArrangedSubview(self.btContact)
        self.searchBar.addSubview(self.lbSearch)
        self.searchBar.addSubview(self.btSearch)
    }
    
    private func setupConstrains(){
        NSLayoutConstraint.activate([
        self.navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
        self.navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        self.searchBar.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
        self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
        self.searchBar.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -20),
        self.searchBar.heightAnchor.constraint(equalToConstant: 55),
        
        self.stackView.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -30),
        self.stackView.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
        self.stackView.widthAnchor.constraint(equalToConstant: 100),
        self.stackView.heightAnchor.constraint(equalToConstant: 30),
        
        self.lbSearch.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
        self.lbSearch.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
        
        self.btSearch.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
        self.btSearch.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
        self.btSearch.widthAnchor.constraint(equalToConstant: 20),
        self.btSearch.heightAnchor.constraint(equalToConstant: 20)
        
        ])
        
    }
    
}
