//
//  Fetcher.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 11/02/2022.
//

import Foundation

class Fetcher {
    
    private var networkClient: NetworkClientPort
    
    init(networkClient: NetworkClientPort) {
        self.networkClient = networkClient
    }
    
    typealias Completion<T> = (Result<T, DataError>) -> Void
    
    func fetch<T: Decodable>(from url: String, completion: @escaping Completion<T>) {
        
        guard let request = buildrequest(endpoint: url) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        networkClient.perform(request) { (data, networkResponse, networkError) in
            if let error = networkError {
                completion(.failure(.network(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(.decoding))
            }
        }
    }
    
    private func buildrequest(endpoint: String) -> URLRequest? {
        
        guard let url = URLComponents(string: endpoint)?.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
}

enum DataError: Error {
    case network(Error)
    case invalidResponse
    case invalidData
    case decoding
    case invalidRequest
}
