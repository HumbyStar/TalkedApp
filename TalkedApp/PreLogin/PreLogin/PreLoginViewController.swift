//
//  PreLoginViewController.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 03/03/23.
//

import UIKit

final class PreLoginViewController: UIViewController {
    
    lazy var customView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonToLoginScreen: ButtonToLoginScreen = {
        let view = ButtonToLoginScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let orange: OrangeColors = .backgroundOrange
        view.backgroundColor = orange.color
        buildApresentationScreen()
        buttonToLoginScreen.delegateButtonsActions(delegate: self)
    }

    func buildApresentationScreen(){
        self.view.addSubview(customView)
        self.view.addSubview(buttonToLoginScreen)
        NSLayoutConstraint.activate([
            self.customView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.customView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.customView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.customView.heightAnchor.constraint(equalToConstant: 570),
            
            buttonToLoginScreen.topAnchor.constraint(equalTo: self.customView.bottomAnchor),
            buttonToLoginScreen.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            buttonToLoginScreen.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            buttonToLoginScreen.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension PreLoginViewController: LoginScreenProtocol {
    func actionLoginButton() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func actionRegisterButton() {
        let registerVC = RegisterViewControler()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

