//
//  RegisterViewController.swift
//  Aula 2 - ViewCode - Backfront
//
//  Created by Humberto Rodrigues on 18/02/23.
//

import UIKit
import Firebase

class RegisterViewControler: UIViewController {
    
    var registerScreen: RegisterScreen?
    var auth: Auth?
    var fireStore: Firestore?
    var alert: Alert?
    
    override func loadView() {
        super.loadView()
        self.registerScreen = RegisterScreen()
        self.view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.receiveTextFieldDelegate(delegate: self)
        registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.fireStore = Firestore.firestore()
        self.alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
}

extension RegisterViewControler: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.checkAndValidTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension RegisterViewControler: LoginScreenProtocol {
    func actionLoginButton() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func actionRegisterButton() {
        guard let register = self.registerScreen else {return}
        
        let userEmail: String = register.getEmail()
        let userPassword: String = register.getPassword()
        
        self.auth?.createUser(withEmail: userEmail, password: userPassword, completion: { result, error in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Erro ao cadastrar")
            } else {
                //Se deu sucesso e criamos um usuário, ele receberá um UID (identificacao)
                if let idUsuario = result?.user.uid {
                    self.fireStore?.collection("usuarios").document(idUsuario).setData([
                        "nome":self.registerScreen?.getName() ?? "",
                        "email":self.registerScreen?.getEmail() ?? "",
                        "id":idUsuario
                    ])
                }
                
                self.alert?.getAlert(title: "Sucesso", message: "Conta cadastrada com sucesso",completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        })
    }
}
