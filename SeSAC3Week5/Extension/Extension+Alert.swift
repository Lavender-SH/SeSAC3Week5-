//
//  Extension+Alert.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/17.
//

import UIKit

extension UIViewController {
    func showAlert(title: String,message: String,button: String,completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default){ action in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
       
        alert.addAction(button)
        alert.addAction(cancel)
    
        present(alert, animated: true)
    }
}
