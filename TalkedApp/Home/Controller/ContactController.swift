//
//  ContactController.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 09/03/23.
//
//  Aqui iremos tratar nossa lógica direta com o BDD, assim iremos ter alguns métodos, como por exemplo, addContact ou saveContact
//
//  ...

import UIKit
import FirebaseFirestore

class ContactController {
    
    private weak var delegate: ContactProtocol?
    
    public func delegate(delegate: ContactProtocol){
        self.delegate = delegate
    }
    
    func addContact(email: String, userLogged: String, idUser: String) {
        if email == userLogged {
            self.delegate?.alertStateError(title: "Erro", message: "Voce adicionou seu proprio email")
            return
        }
        
        //verificar se existe usuario no firebase(BDD)
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            
            //conta total de retorno
            if let totalItens = snapshot?.count {
                if totalItens == 0 {
                    self.delegate?.alertStateError(title: "Erro", message: "Usuario não cadastrado")
                    return
                }
            }
            
            //salvar contato
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    self.saveContact(contactData: data, idUser: idUser)
                }
            }
        }
    }
    
    func saveContact(contactData: Dictionary<String,Any>, idUser: String) {
        let contact = Contact(dicionario: contactData)
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").document(idUser).collection("contatos").document(contact.id ?? "").setData(contactData) {
            error in
            if error == nil {
                self.delegate?.successContact()
            }
        }
    }
    
}
