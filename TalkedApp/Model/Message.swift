//
//  Message.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import Foundation

class Message {
    var texto: String?
    var idUsuario: String?
    
    init(dicionario: [String:Any]) {
        self.texto = dicionario["texto"] as? String
        self.idUsuario = dicionario["idUsuario"] as? String
    }
}
