//
//  UIImageView+Extension.swift
//  TestingForJob
//
//  Created by Александр on 01.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: String?) {
        guard let urlString = url, let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
