//
//  ContactProtocol.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 09/03/23.
//

import UIKit

protocol ContactProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func successContact()
}


