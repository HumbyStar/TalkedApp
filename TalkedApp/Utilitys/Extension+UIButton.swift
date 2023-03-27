//
//  Extension+UIButton.swift
//  TalkedApp
//
//  Created by Humberto Rodrigues on 10/03/23.
//

import UIKit

extension UIButton {
    func touchToAnimate(target: UIButton){
        UIView.animate(withDuration: 0.1, delay: 0 ,usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            
            target.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
            
        }, completion: { finish in
            
            UIButton.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut ,animations: {
                target.transform = .identity
            })
            
        })}
}
