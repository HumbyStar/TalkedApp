//
//  ViewController.swift
//  Aula 2 a Aula 8 - ViewCode - Backfront - 16/02/2023
//
//  Aula 9 a Aula 17 - ViewCode - BackFront - 18/02/2023
//
//  Aula 18 a Aula 24 - ViewCode - BackFront - 22/02/2023
//
//
//  Created by Humberto Rodrigues on 16/02/23.
//
//  MARK: Imagens no formato svg podem receber tipos de cor com tintColor

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var loginScreen: LoginScreen?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        super.loadView()
        
        self.loginScreen = LoginScreen()
        self.view = loginScreen
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        
        self.loginScreen?.delegate(delegate: self)
        
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        
        self.auth = Auth.auth()
        
        self.alert = Alert(controller: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.checkAndValidTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension LoginViewController: LoginScreenProtocol{
    func actionLoginButton() {
        
        guard let login = loginScreen else {return}
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { user, error in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Dados incorretos")
            } else {
                if user == nil {
                    self.alert?.getAlert(title: "Atenção", message: "Tivemos um problema inesperado, tente novamente mais tarde")
                } else {
//                    self.alert?.getAlert(title: "Parabens", message: "Login Efetuado com Sucesso", completion: {
//                        let homevc = HomeViewController()
//                        self.navigationController?.present(homevc, animated: true)
                    //  })
                    let vc = HomeViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                 
                }
            }
        })
    }
    
    func actionRegisterButton() {
        print("Estou registrando..")
        navigationController?.pushViewController(RegisterViewControler(), animated: true)
    }
}
