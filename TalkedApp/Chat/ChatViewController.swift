//
//  ChatViewController.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 10/03/23.
//
//  Esta tela será referente a célula selecionada, os dados serão enviados para cá

import UIKit
import Firebase
import AVFoundation


class ChatViewController: UIViewController {
    
    var listaMensagem:[Message] = []                 // Preciso gerar um Array de mensagem
    var idUsuarioLogado: String?                     // Aqui será o MEU ID, o ID de quem está usando
    var contato: Contact?                            // Essa classe receberá do Banco de dados, e criará o objeto contato, contendo ID, e Name
    var mensagemListener: ListenerRegistration?      // ...
    var auth: Auth?                                  // Classe responsável por autenticar
    var db: Firestore?                               // Classe responsável por buscar informações do banco de dados
    var nomeContato: String?                         // Variável que irá receber o nome do usuário que estou conversando
    var nomeUsuarioLogado: String?                   // Meu nome (de quem está usando o app)
    var chatViewScreen: ChatViewScreen?              // Minha view customizada que contém os elementos de UI/UX
    
    override func loadView() {
        super.loadView()
        self.chatViewScreen = ChatViewScreen()
        self.view = chatViewScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addListenerRecuperarMensagens()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mensagemListener?.remove()
    
//          Atenção, é muito importante, quando se trabalha com listener, ao sair da viewController é necessário remover o listener
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDataFirebase()
        self.configChatView()
    }
    
    private func configChatView() {
        self.chatViewScreen?.configNavView(controller: self)
        self.chatViewScreen?.delegate(delegate: self)
        self.chatViewScreen?.tableViewDelegate(delegate: self, dataSource: self)
    }
    
    private func configDataFirebase() {
        self.auth = Auth.auth()                                     // Classe responsável por autenticar
        self.db = Firestore.firestore()                             // Classe responsável pelo BANCO de DADOS
        
        //Vamos a validação, preciso recuperar meu ID do usuário
        if let id = self.auth?.currentUser?.uid {                   // Se ID receber o ID da classe Auth, eu coloco na constante
            self.idUsuarioLogado = id                               // Atribuo a variavel de escopo meu ID
            self.recuperarDadosUsuarioLogado()
        }
        
        if let nome = self.contato?.name {
            self.nomeContato = nome
        }
    }
    
    //MARK: - Método utilizado para recuperar o listener, contém como usa-lo e configura-lo pra ficar atento as mensagens
    private func addListenerRecuperarMensagens() {
        if let idDestinatario = self.contato?.id {
            mensagemListener = db?.collection("mensagens").document(self.idUsuarioLogado ?? "").collection(idDestinatario).order(by: "data", descending: false).addSnapshotListener({ snapshot, error in
                //Limpar todas as mensagens primeiro
                self.listaMensagem.removeAll()          // Relacionado a mensagens prévias utilizadas na tableView
                
                //Recuperar dados
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.listaMensagem.append(Message(dicionario: dados))
                    }
                    self.chatViewScreen?.reloadTableView()
                }
            })
            
                //Ou seja adicionando o listener, qualquer alteração relacionada em mensagens ira refletir na tabela
        }
    }
    
    private func recuperarDadosUsuarioLogado() {
        
//      Função responsável por recuperar dados APENAS do usuário.
        
        let usuarios = self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "")
//          Se eu conseguir acessar minha collection "Usuarios" -> Recupero um documento sobre o usuário logado através do ID
//          Porém isso tudo foi atribuído a uma constante chamada usuarios, então preciso agora de fato conseguir o documento com getDocuments

        usuarios?.getDocument(completion: { snapshot, error in
            if error == nil {
                let dados = Contact(dicionario: snapshot?.data() ?? [:])
                
//                  A constante dados foi preenchida com um objeto Contact, e seu inicializador foi preenchido com a resposta da closure
//                  snapshot é os dados que tenho para preencher a constante, esses dados precisam ser inicializados data()
//                  data() -> Devolve a informação como um dicionário que é justamente o que preciso para ler dados
                
                self.nomeUsuarioLogado = dados.name ?? ""
//                  A ultima etapa é extrair de dados o que preciso que é meu NOME
            }
        })
    }
    
    private func salvarMensagem(idRemetente: String, idDestinatario: String, mensagem: [String:Any]) {
        self.db?.collection("mensagens").document(idRemetente).collection(idDestinatario).addDocument(data: mensagem)
//          Vou acessar ambos os diretórios e salvar a mensagem em ambas os bancos de dados de cada usuário
        self.chatViewScreen?.tfInputMessage.text = ""
    }

    private func salvarConversa(idRemetente: String, idDestinatario: String, conversa: [String:Any]) {
        self.db?.collection("conversas").document(idRemetente).collection("ultimas_conversas").document(idDestinatario).setData(conversa)
//          Vou acessar ambos os diretórios e salvar a conversa em ambas os bancos de dados de cada usuário
    }
    
    @objc func tapToBtBack(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMensagem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mensagens = self.listaMensagem[indexPath.row]
        let idUsuario = mensagens.idUsuario // IdUsuário pode ser tanto eu quanto o destinatário
        
        if self.idUsuarioLogado != idUsuario { //Se essa condição é verdadeira então estou recebendo a mensagem
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextfieldTableViewCell.identifier, for: indexPath) as? IncomingTextfieldTableViewCell
            //MARK: cell?.transform = CGAffineTransform(scaleX: 1, y: -1)  --> Observar o que de fato faz
            cell?.setupCell(message: mensagens)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextfieldTableViewCell.identifier, for: indexPath) as? OutgoingTextfieldTableViewCell
            //MARK: cell?.transform = CGAffineTransform(scaleX: 1, y: -1)  --> Observar o que de fato faz
            cell?.setupCell(message: mensagens)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//          Primeiro ponto: Definir altura das células
        let description = self.listaMensagem[indexPath.row].texto ?? ""
        let font = UIFont(name: CustomFont.montSerrat, size: 14) ?? UIFont()
        let estimateHeight = description.heightWithConstrainedWidth(width: 220, font: font)
        return CGFloat(65 + estimateHeight)
        
//           O método heightWithContrainedWidht retorna um cgFloat que é somado (segundo Caio) com 65, 65 é o espaçamento dos meus elementos contendo top, bottom das minhas constrains.
    }
}

extension ChatViewController: ChatViewScreenProtocol {
    func actionPushMessage() {
//              ActionPushMessage é uma função com o objetivo de enviar a mensagem para o remetente.
        let message = self.chatViewScreen?.tfInputMessage.text ?? ""
    
        if let idUsuarioDestinatario = contato?.id {
//              Criei uma constante para resgatar o ID do contato que quero enviar a mensagem.
            
//              Agora eu vou criar um dicionário chamado mensagem para enviar o conteúdo em si da mensagem
//              FieldValue.serverTimeStamp() --> Recupera com exatidão a hora e data da mensagem enviada.
            let mensagem: Dictionary <String,Any> = [
                "idUsuario": self.idUsuarioLogado ?? "",
                "texto": message,
                "data": FieldValue.serverTimestamp()
            ]
            
            self.salvarMensagem(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, mensagem: mensagem)
            
//              Foi explicado que eu preciso salvar a mensagem tanto no meu banco,quanto no banco de dados de quem vai receber a mensagem em si
            
            self.salvarMensagem(idRemetente: idUsuarioDestinatario, idDestinatario: self.idUsuarioLogado ?? "", mensagem: mensagem)
//              Salvei a mensagem no banco de dados do usuário que vai receber a mensagem.
            
            var conversa: [String:Any] = ["ultimaMensagem":message]
//              Lembrando que, conversa é um objeto que contem o objeto mensagens.
            
//              Salvar conversa para remetente(Que nesse caso é quem vai receber)
            conversa["idRemetente"] = idUsuarioLogado ?? ""
            conversa["idDestinatario"] = idUsuarioDestinatario
            conversa["nomeUsuario"] = self.nomeContato ?? ""
            
            self.salvarConversa(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, conversa: conversa)
            
//            Salvar conversa para destinatário(Que nesse caso sou eu)
            conversa["idRemetente"] = idUsuarioDestinatario
            conversa["idDestinatario"] = idUsuarioLogado ?? ""
            conversa["nomeUsuario"] = self.nomeUsuarioLogado ?? ""
            
            self.salvarConversa(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado ?? "", conversa: conversa)
        }
    }
}
