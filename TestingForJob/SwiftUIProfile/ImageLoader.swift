//
//  ImageLoader.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader:ObservableObject {
    @Published var downloadImage:UIImage?
    
    func fetchImage(url:String){
        guard let imageURL = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: imageURL){ data, response, error in
            guard let data = data, error == nil else {return}
            
            DispatchQueue.main.async {
                self.downloadImage = UIImage(data: data)
            }
            
        }.resume()
    }
}
