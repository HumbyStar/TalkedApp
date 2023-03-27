//
//  Alert.swift
//  Aula 2 - ViewCode - Backfront
//
//  Created by Humberto Rodrigues on 22/02/23.
//

import Foundation
import UIKit

class Alert: NSObject {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String, message: String, completion:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        alertController.addAction(cancelAction)
        self.controller.present(alertController, animated: true, completion: nil)
        
    }
    
    func addContact(completion: ((_ value: String) -> Void)? = nil) {
        var _textField: UITextField?
        let alert = UIAlertController(title: "Adicionar Usuário", message: "Digite um email válido", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Adicionar", style: .default) { (action) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancel)
        
        //MARK: Ponto importante
        alert.addTextField(configurationHandler: {(textfield: UITextField) in
            _textField = textfield
            textfield.placeholder = "Email:"
        })
        
        self.controller.present(alert, animated: true)
        
    }
}
