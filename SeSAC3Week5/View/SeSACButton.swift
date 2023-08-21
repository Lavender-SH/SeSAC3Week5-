//
//  SeSACButton.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/21.
//

import UIKit

class SeSACButton: UIButton {
    
    @IBInspectable
    var jack: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth}
        set { layer.borderWidth = newValue }
    }
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor!)}
        set { layer.borderColor = newValue.cgColor}
    }
    
    
    
    
    
}
//func configureButtonStyle(_ button: UIButton) {
//    button.layer.borderWidth = 1
//    button.layer.borderColor = UIColor.black.cgColor
//
//    button.layer.cornerRadius = button.frame.height / 3
//    button.clipsToBounds = true
//}
