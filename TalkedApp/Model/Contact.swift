//
//  Contact.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 06/03/23.
//

import Foundation

class Contact {
    var id: String?
    var name: String?
    
    init(dicionario: [String:Any]?) {
        self.id = dicionario?["id"] as? String
        self.name = dicionario?["nome"] as? String
    }
    
    convenience init(id: String?, name:String?) {
        self.init(dicionario: nil)
        self.id = id
        self.name = name
    }
}
