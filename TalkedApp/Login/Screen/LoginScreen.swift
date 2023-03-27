//
//  LoginScreen.swift
//  Aula 2 - ViewCode - Backfront
//
//  Created by Humberto Rodrigues on 16/02/23.
//

import UIKit

class LoginScreen: UIView {
    
    
    private weak var delegate: LoginScreenProtocol?
    
    func delegate(delegate: LoginScreenProtocol?) {
        self.delegate = delegate
    } // Essa função seria tipo um get, apenas para ter acesso ao private dessa classe.
    
    lazy var lbLogin: UILabel = {
        let label = UILabel()
        label.text = "TalkedApp"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ivMainLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "image2")
        image.clipsToBounds = true
        image.layer.cornerRadius = 150
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var tfEmail: UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu Email:"
        tf.text = "betogrt300@gmail.com"
        tf.textColor = .darkGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var tfPassworld: UITextField = {
        let tf = UITextField()
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isSecureTextEntry = true // Para não vermos os caracteres
        tf.placeholder = "Digite sua Senha:"
        tf.textColor = .darkGray
        tf.text = "123456"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var btLogin: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Entrar", for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 18)
        bt.setTitleColor(OrangeColors.backgroundOrange.color, for: .normal)
        bt.clipsToBounds = true //dar acesso as bordas
        bt.layer.cornerRadius = 7.5
        bt.backgroundColor = OrangeColors.textColor.color
        bt.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return bt
    }()
    
    lazy var btRegister: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.titleLabel?.font = .systemFont(ofSize: 14)
        bt.setTitle("Não possuo Conta", for: .normal)
        bt.setTitleColor(OrangeColors.textColor.color, for: .normal)
        bt.addTarget(self, action: #selector(tappedToRegister), for: .touchUpInside)
        return bt
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        extrasFeatures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func checkAndValidTextField() {
        let login: String = tfEmail.text ?? ""
        let passworld: String = tfPassworld.text ?? ""
        
        if !login.isEmpty && !passworld.isEmpty {
            enableBtLogin(isEnable: true)
        } else {
            enableBtLogin(isEnable: false)
        }
    }
    
    private func enableBtLogin(isEnable: Bool) {
        if isEnable {
            btLogin.isEnabled = isEnable
            btLogin.alpha = 1.0
        } else {
            btLogin.isEnabled = isEnable
            btLogin.alpha = 0.5
        }
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.tfEmail.delegate = delegate
        self.tfPassworld.delegate = delegate
    }
    
    @objc func tappedLoginButton(){
        self.delegate?.actionLoginButton()
    }
    
    @objc func tappedToRegister(){
        self.delegate?.actionRegisterButton()
    }
    
    private func configureBackground() {
        self.backgroundColor = OrangeColors.backgroundOrange.color
    }
    
    public func getEmail() -> String {
        return self.tfEmail.text ?? ""
    }
    
    public func getPassword() -> String {
        return self.tfPassworld.text ?? ""
    }
    
    private func extrasFeatures(){
        self.enableBtLogin(isEnable: false)
        configureBackground()
        [lbLogin, ivMainLogo, tfEmail, tfPassworld,btLogin,btRegister].forEach{
            self.addSubview($0)
        }
        setUPConstraint()
    }
    
    
    
    func setUPConstraint() {
        NSLayoutConstraint.activate([
            lbLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            lbLogin.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 70),
            ivMainLogo.topAnchor.constraint(equalTo: lbLogin.bottomAnchor, constant: 10),
            ivMainLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ivMainLogo.widthAnchor.constraint(equalToConstant: 300),
            ivMainLogo.heightAnchor.constraint(equalToConstant: 300),
            
            tfEmail.topAnchor.constraint(equalTo: ivMainLogo.bottomAnchor, constant: 10),
            tfEmail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tfEmail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tfEmail.heightAnchor.constraint(equalToConstant: 45),

            tfPassworld.topAnchor.constraint(equalTo: tfEmail.bottomAnchor,constant: 10),
            tfPassworld.leadingAnchor.constraint(equalTo: tfEmail.leadingAnchor),
            tfPassworld.trailingAnchor.constraint(equalTo: tfEmail.trailingAnchor),
            tfPassworld.heightAnchor.constraint(equalTo: tfEmail.heightAnchor),

            btLogin.topAnchor.constraint(equalTo: tfPassworld.bottomAnchor,constant: 25),
            btLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            btLogin.widthAnchor.constraint(equalToConstant: 100),
            btLogin.heightAnchor.constraint(equalTo: tfEmail.heightAnchor),
            
            btRegister.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            btRegister.widthAnchor.constraint(equalToConstant: 200),
            btRegister.heightAnchor.constraint(equalToConstant: 50),
            btRegister.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
