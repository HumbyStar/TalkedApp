//
//  HomeViewController.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 05/03/23.
//

import UIKit
import Firebase

final class HomeViewController: UIViewController {
    
    var homeScreen: HomeScreen?
    var alert: Alert?
    
    var auth: Auth?
    var db: Firestore?
    
    var idUsuarioLogado: String?
    var screenContact: Bool?
    var emailUsuarioLogado: String?
    
   
    var contact: ContactController?
    var listContact: [Contact] = []
    var chats: [Conversation] = []
    var chatListener: ListenerRegistration? // Ja vem do Firebase
    
    
    override func loadView() {
        super.loadView()
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = OrangeColors.textColor.color
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.configContact()
        self.getChats()
        
    }
    
    private func configHomeView() {
        self.homeScreen?.navView.navViewDelegate(delegate: self)
    }
    
    private func configCollectionView(){
        self.homeScreen?.collectionDelegate(delegate: self, datasource: self)
    }
    
    private func configAlert(){
        self.alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //recuperar id usuario logado
        
        if let currentUser = auth?.currentUser {
            self.idUsuarioLogado = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
            
        }
    }
    
    private func configContact() {
        self.contact = ContactController()
        self.contact?.delegate(delegate: self)
    }
    
    func getChats() { //addlisternerRecuperarConversas
        if let idUserLogado = auth?.currentUser?.uid {
            self.chatListener = db?.collection("conversas").document(idUserLogado).collection("ultimas_conversas").addSnapshotListener({ snapshot, error in
                    if error == nil {
                        self.chats.removeAll()
                        
                        if let snapshot = snapshot{
                            for document in snapshot.documents{
                                let data = document.data()
                                self.chats.append(Conversation(dicionario: data))
                            }
                            self.homeScreen?.reloadCollectionView()
                        }
                        self.homeScreen?.reloadCollectionView()
                        // estudar mais aprofundado sobre listener e como usa-lo sem pesar no meu aplicativo
                    }
            })
        }
    }
    
    func getContact() {
        self.listContact.removeAll()
        self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "").collection("contatos").getDocuments(completion: { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let contactData = document.data()
                        self.listContact.append(Contact(dicionario: contactData))
                    }
                    self.homeScreen?.reloadCollectionView()
                }
            } else {
                print("Erro getContact")
                return
            }
        })
    }
}

extension HomeViewController: NavViewProtocol {
    func screenTypeButton(type: TypeButton) {
        switch type {
        case .contact:
            self.screenContact = true
            self.getContact()
            self.chatListener?.remove() // Se estou em contact é porque não estou em conversation
        case .conversation:
            self.screenContact = false
            self.getChats()
            self.homeScreen?.reloadCollectionView()
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.screenContact ?? false {
            return self.listContact.count + 1 //+1 é uma celula que fara a exibição para adicionar um contato
        } else {
            return self.chats.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.screenContact ??  false { // Se minha tela de contato for true
            
            if indexPath.row == self.listContact.count { // Se meu indice é igual a listContact.count, sobra o indice + 1
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastMessageCollectionViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMessageCollectionViewCell.identifier, for: indexPath) as? DetailMessageCollectionViewCell
                
                cell?.setupViewContact(contact: self.listContact[indexPath.row])
                return cell ?? UICollectionViewCell()
            }

        } else {
            // Célula de Conversas
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMessageCollectionViewCell.identifier, for: indexPath) as? DetailMessageCollectionViewCell
            cell?.setupConversation(conversation: self.chats[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.screenContact ?? false {
            if indexPath.row == self.listContact.count {
                self.alert?.addContact { emailDigitado in
                    self.contact?.addContact(email: emailDigitado, userLogged: self.emailUsuarioLogado ?? "", idUser: self.idUsuarioLogado ?? "")
                }
            } else { //Se não for screenContact é a chatViewController
                let chatViewController = ChatViewController()
                chatViewController.contato = listContact[indexPath.row]
                self.navigationController?.pushViewController(chatViewController, animated: true)
            }
        } else {
            //Preciso recuperar um chat de forma individual
            let chatViewController = ChatViewController()
            let chat = chats[indexPath.row]
            chatViewController.contato = Contact(id: chat.idDestinatario, name: chat.nome)
            navigationController?.pushViewController(chatViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeViewController: ContactProtocol {
    func alertStateError(title: String, message: String) {
        self.alert?.getAlert(title: title, message: message)
    }
    
    func successContact() {
        self.alert?.getAlert(title: "Sucesso", message: "Contato Adicionado",completion: {
            self.getContact()
        })
    }
}
