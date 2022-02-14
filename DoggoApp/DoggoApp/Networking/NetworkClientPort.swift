//
//  NetworkClient.swift
//  DoggoApp
//
//  Created by Faisal Rahman on 11/02/2022.
//

import Foundation

public protocol NetworkClientPort {
    func perform(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}
