//
//  buttonToLoginScreen.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 05/03/23.
//

import UIKit

class ButtonToLoginScreen: UIView {
    
    private weak var delegate: LoginScreenProtocol?
    
    lazy var btRegister: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Sign Up", for: .normal)
        bt.backgroundColor =  OrangeColors.textColor.color
        bt.setTitleColor(OrangeColors.backgroundOrange.color, for: .normal)
        bt.layer.masksToBounds = false
        bt.layer.cornerRadius = 20
        bt.addTarget(self, action: #selector(tapInRegister), for: .touchUpInside)
        return bt
    }()
    
    lazy var btLogin: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Login", for: .normal)
        bt.setTitleColor(OrangeColors.textColor.color, for: .normal)
        bt.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupContraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func delegateButtonsActions(delegate: LoginScreenProtocol) {
        self.delegate = delegate
    }
    
    @objc func tapInRegister() {
        delegate?.actionRegisterButton()
    }
    
    @objc func tapToLogin() {
        delegate?.actionLoginButton()
    }
    
    private func addSubView() {
        self.addSubview(btRegister)
        self.addSubview(btLogin)
    }
    
    private func setupContraits() {
        NSLayoutConstraint.activate([
            btRegister.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            btRegister.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btRegister.widthAnchor.constraint(equalToConstant: 100),
            btRegister.heightAnchor.constraint(equalToConstant: 40),
            
            btLogin.topAnchor.constraint(equalTo: btRegister.bottomAnchor,constant: 10),
            btLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btLogin.widthAnchor.constraint(equalToConstant: 100),
            btLogin.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
