//
//  NetworkClient.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 11/02/2022.
//

import Foundation

class NetworkClient: NetworkClientPort {
    func perform(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { responseData, response, responseError in
            DispatchQueue.main.async {
                completionHandler(responseData, response, responseError)
            }
        }
        
        task.resume()
    }
}
