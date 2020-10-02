//
//  UIViewController+Extension.swift
//  TestingForJob
//
//  Created by Александр on 01.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okButton = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}
