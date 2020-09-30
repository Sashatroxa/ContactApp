//
//  Api.swift
//  TestingForJob
//
//  Created by Александр on 28.09.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

enum NewResult<Value>{
    case success(Value)
    case partialSuccess(String)
    case failure(Error)
}

//Mark: Get first page

func getAllData(completion: ((NewResult<AllData>) -> Void)?){
    
    var request = URLRequest(url:URL(string: "https://dummyapi.io/data/api/user")!)
    
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.setValue("5f673807c6cba67fb8284491", forHTTPHeaderField: "app-id")
    
    URLSession.shared.dataTask(with: request) { (responseData, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                completion?(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let address = try decoder.decode(AllData.self, from: jsonData)
                    completion?(.success(address))
                } catch {
                    completion?(.failure(error))
                }
            }
        }
    }.resume()
}

//Mark: Get data from next pages

func fetchData<T: Decodable>(for url: URLRequest, model: T.Type, completion: @escaping (T?) -> Void) {
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("\n Error JSON fetching: ", error.localizedDescription)
            completion(nil)
            return
        }
        
        guard let jsonData = data else { return }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: jsonData)
            
            DispatchQueue.main.async {
                completion(data)
            }
        } catch let error {
            print("\n Error JSON decode: ", error.localizedDescription)
            completion(nil)
        }
    }.resume()
}
