//
//  User.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import Foundation

class User {
    var name: String?
    var email: String?
    
    init(dicionario: [String:Any]) {
        self.name = dicionario["nome"] as? String
        self.email = dicionario["email"] as? String
    }
}
