//
//  RegisterScreen.swift
//  Aula 2 - ViewCode - Backfront
//
//  Created by Humberto Rodrigues on 18/02/23.
//

import UIKit

class RegisterScreen: UIView {
    
    private weak var delegate: LoginScreenProtocol?
    
    func delegate(delegate: LoginScreenProtocol?) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.enableButton(isEnable: false)
        configureBackground()
        extrasFeatures()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bannerImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 150
        img.clipsToBounds = true
        img.layer.borderWidth = 5
        img.layer.borderColor = OrangeColors.backgroundOrange.color.cgColor
        img.image = UIImage(named:"image2")
        img.tintColor = .white
        return img
    }()
    
    lazy var tfEmail: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu Email: "
        tf.font = .systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var tfName: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu Nome: "
        tf.font = .systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var tfPassworld: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite sua senha: "
        tf.isSecureTextEntry = true
        tf.font = .systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var btRegister: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Cadastrar", for: .normal)
        bt.setTitleColor(OrangeColors.backgroundOrange.color, for: .normal)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 7.5
        bt.backgroundColor = OrangeColors.textColor.color
        bt.addTarget(self, action: #selector(tapToRegister), for: .touchUpInside)
        return bt
    }()
    
    lazy var btLogin: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.titleLabel?.font = .systemFont(ofSize: 14)
        bt.setTitle("Já possuo Conta", for: .normal)
        bt.setTitleColor(OrangeColors.textColor.color, for: .normal)
        bt.addTarget(self, action: #selector(tapToLogin), for: .touchUpInside)
        return bt
    }()
    
    @objc func tapToRegister(){
        self.delegate?.actionRegisterButton()
    }
    
    @objc func tapToLogin(){
        self.delegate?.actionLoginButton()
    }
    
    public func receiveTextFieldDelegate(delegate: UITextFieldDelegate?) {
        self.tfName.delegate = delegate
        self.tfEmail.delegate = delegate
        self.tfPassworld.delegate = delegate
    }
    
    public func checkAndValidTextField() {
        let email: String = tfEmail.text ?? ""
        let passworld: String = tfPassworld.text ?? ""
        let name: String = tfName.text ?? ""
        
        if !email.isEmpty && !passworld.isEmpty && !name.isEmpty {
            enableButton(isEnable: true)
        } else {
            enableButton(isEnable: false)
        }
    }
    
    private func enableButton(isEnable: Bool) {
        
        if isEnable {
            self.btRegister.isEnabled = isEnable
            self.btRegister.alpha = 1.0
        } else {
            self.btRegister.alpha = 0.5
            self.btRegister.isEnabled = isEnable
        }
        
    }
    
    private func configureBackground() {
        self.backgroundColor = OrangeColors.backgroundOrange.color
    }
    
    public func getName() -> String {
        return self.tfName.text ?? ""
    }
    
    public func getEmail() -> String {
        return self.tfEmail.text ?? ""
    }
    
    public func getPassword() -> String {
        return self.tfPassworld.text ?? ""
    }
    
    private func extrasFeatures(){
        [bannerImage, tfEmail, tfName, tfPassworld, btRegister, btLogin].forEach{
            addSubview($0)
        }
       setupConstrains()
    }
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
            bannerImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bannerImage.widthAnchor.constraint(equalToConstant: 300),
            bannerImage.heightAnchor.constraint(equalToConstant: 300),
            
            self.tfEmail.topAnchor.constraint(equalTo: bannerImage.bottomAnchor,constant: 15),
            self.tfEmail.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            self.tfEmail.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            self.tfEmail.heightAnchor.constraint(equalToConstant: 50),
            
            self.tfName.topAnchor.constraint(equalTo: tfEmail.bottomAnchor,constant: 15),
            self.tfName.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            self.tfName.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            self.tfName.heightAnchor.constraint(equalToConstant: 50),
            
            
            self.tfPassworld.topAnchor.constraint(equalTo: tfName.bottomAnchor, constant: 10),
            self.tfPassworld.leadingAnchor.constraint(equalTo: tfEmail.leadingAnchor),
            self.tfPassworld.trailingAnchor.constraint(equalTo: tfEmail.trailingAnchor),
            self.tfPassworld.heightAnchor.constraint(equalTo: tfEmail.heightAnchor),

            self.btRegister.topAnchor.constraint(equalTo: tfPassworld.bottomAnchor,constant: 35),
            self.btRegister.widthAnchor.constraint(equalToConstant: 100),
            self.btRegister.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.btRegister.heightAnchor.constraint(equalTo: tfEmail.heightAnchor),
            
            btLogin.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            btLogin.widthAnchor.constraint(equalToConstant: 200),
            btLogin.heightAnchor.constraint(equalToConstant: 50),
            btLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
