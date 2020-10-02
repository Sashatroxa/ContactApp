//
//  Api.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

class Network {
    
    static let shared = Network()
    
    private init() {}
    
    func fetchData<T: Decodable>(for url: URLRequest, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\n Error JSON fetching: ", error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let jsonData = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(T.self, from: jsonData)
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch let error {
                print("\n Error JSON decode: ", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}
