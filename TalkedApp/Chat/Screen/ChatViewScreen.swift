//
//  ChatViewScreen.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 10/03/23.
//

import UIKit
import Firebase
import AVFoundation

class ChatViewScreen: UIView {
    
    private weak var delegate: ChatViewScreenProtocol?
    
    public func delegate(delegate: ChatViewScreenProtocol?) {
        self.delegate = delegate
    }
    
    var btConstraints: NSLayoutConstraint?
    var player: AVAudioPlayer?
    
    //MARK: - Custom Navigation
    lazy var navigation: ChatNavigationView = {
        let view = ChatNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageInputView: UIView = { // Responsável pelo fundo das mensagens
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var messageBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = OrangeColors.textColor.color
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var btSend: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setImage(UIImage(systemName: "paperplane")?.withTintColor(OrangeColors.lightOrange.color), for: .normal )
        bt.backgroundColor = OrangeColors.backgroundOrange.color
        bt.layer.shadowColor = OrangeColors.mediumOrange.color.cgColor
        bt.layer.shadowRadius = 10
        bt.layer.shadowOffset = CGSize(width: 0, height: 5)
        bt.layer.shadowOpacity = 0.3
        bt.layer.cornerRadius = 23
        bt.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return bt
    }()
    
    lazy var tfInputMessage: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        tf.placeholder = "Digite Aqui"
        tf.font = UIFont(name: CustomFont.montSerrat, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.transform = CGAffineTransform(scaleX: 1, y: 1)
        tableView.register(IncomingTextfieldTableViewCell.self, forCellReuseIdentifier: IncomingTextfieldTableViewCell.identifier)
        tableView.register(OutgoingTextfieldTableViewCell.self, forCellReuseIdentifier: OutgoingTextfieldTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview()
        setupConstraints()
        
        //MARK: Catching from system a message through notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.willUpKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willUpKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //MARK: Keyboard Up
        self.tfInputMessage.addTarget(self, action: #selector(self.textfieldDidChange(_:)), for: UIControl.Event.editingChanged) //Só liberará teclado se changedEditing

        self.btConstraints = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.addConstraint(btConstraints ?? NSLayoutConstraint())
        self.btSend.isEnabled = false
        self.btSend.layer.opacity = 0.4
        self.btSend.transform = .init(scaleX: 0.8, y: 0.8)
        self.tfInputMessage.becomeFirstResponder()
        //MARK: Keyboard Down
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func reloadTableView() {
        self.tableView.reloadData()
    }

    public func configNavView(controller: ChatViewController) {
        self.navigation.controller = controller
    }
    
    //MARK: - Adapting TableView when keyboard showing
    @objc func willUpKeyboard(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue // CGRect: A structure that contains the location and dimensions of a rectangle.
            let keyboardHeight = keyboardRectangle.height
            // também poderia ter simplificado passando direto cgRectValue.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            self.btConstraints?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y - keyboardHeight : self.tableView.center.y + keyboardHeight
            
            UIView.animate(withDuration: 0.1, delay: 0,options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: { (completed) in
                //Aqui posso colocar uma possivel configuração caso eu queira fazer algo após a keyboard abaixar
            })
            
            
        }
    }
    
    
    //MARK: - Call methods to finally send the message
    @objc func sendMessage() {
        self.btSend.touchToAnimate(target: self.btSend)
        self.playSound()
        self.delegate?.actionPushMessage()
        self.startPushMessage()
    }
    
    //MARK: - Set Sound when send message
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else {return}
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else {return}
            player.play()
        } catch {
            print(error)
        }
    }
    
    //MARK: - Pushing message + Config Animated views
    private func startPushMessage() {
        self.tfInputMessage.text = ""
        self.btSend.isEnabled = false
        self.btSend.layer.opacity = 0.4
        self.btSend.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
    }
    
    //MARK: - Setup Subviews + Constraints
    private func addSubview() {
        self.addSubview(self.tableView)
        self.addSubview(self.navigation)
        self.addSubview(messageInputView)
        self.messageInputView.addSubview(self.messageBar)
        self.messageBar.addSubview(btSend)
        self.messageBar.addSubview(tfInputMessage)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.navigation.topAnchor.constraint(equalTo: self.topAnchor),
            self.navigation.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navigation.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navigation.heightAnchor.constraint(equalToConstant: 140),
            
            self.tableView.topAnchor.constraint(equalTo: self.navigation.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            self.messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            self.messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor,constant: 20),
            self.messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor, constant: -20),
            self.messageBar.heightAnchor.constraint(equalToConstant: 55),
            self.messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            self.btSend.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor, constant: -15),
            self.btSend.heightAnchor.constraint(equalToConstant: 55),
            self.btSend.widthAnchor.constraint(equalToConstant: 55),
            self.btSend.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor, constant: -10),
            self.btSend.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor),
            
            self.tfInputMessage.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor, constant: 20),
            self.tfInputMessage.trailingAnchor.constraint(equalTo: self.btSend.leadingAnchor, constant: -5),
            self.tfInputMessage.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor),
            self.tfInputMessage.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    
}

//  MARK: - Animating

extension ChatViewScreen: UITextFieldDelegate {
    @objc func textfieldDidChange(_ textfield: UITextField) {
        if tfInputMessage.text == "" { // Se estiver vazio
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.btSend.isEnabled = false
                self.btSend.layer.opacity = 0.4
                self.btSend.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } completion: { _ in
                //Nenhuma ação com completion
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.btSend.isEnabled = true
                self.btSend.layer.opacity = 1
                self.btSend.transform = .identity
            }
        }
    }
    
    
}
