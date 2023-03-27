//
//  UIColors.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 03/03/23.
//

import UIKit

enum OrangeColors {
    case lightOrange
    case mediumOrange
    case darkOrange
    case backgroundOrange
    case textColor
    
    var color: UIColor {
        switch self {
        case .lightOrange:
            return UIColor(red: 1.0, green: 160/255, blue: 122/255, alpha: 1.0)
        case .mediumOrange:
            return UIColor(red: 1.0, green: 127/255, blue: 80/255, alpha: 1.0)
        case .darkOrange:
            return UIColor(red: 1.0, green: 87/255, blue: 51/255, alpha: 1.0)
        case .backgroundOrange:
            return UIColor(red: 255/255, green: 189/255, blue: 89/255, alpha: 1.0)
        case .textColor:
            return UIColor(red: 255/255, green: 234/255, blue: 170/255, alpha: 1)
        }
    }
}
