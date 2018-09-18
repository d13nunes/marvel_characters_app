//
//  BaseRequest.swift
//  MarvelApp
//
//  Created by Diogo Nunes on 21/09/2018.
//  Copyright © 2018 Diogo Nunes. All rights reserved.
//

import Foundation

protocol BaseRequest {
    var environment: Environment {get}
    var session: URLSession {get}
}

extension BaseRequest {
    
    func genericRequest<T: Decodable>(path: String, queryItems: [URLQueryItem], completion: @escaping (T?, Error?)->Void)  -> URLSessionTask {
        let baseEndpoint = environment.baseURL
        return genericRequest(ulrString: baseEndpoint.appending(path), queryItems: queryItems, completion: completion)
    }
    
    func genericRequest<T: Decodable>(ulrString: String, queryItems: [URLQueryItem], completion: @escaping (T?, Error?)->Void)  -> URLSessionTask {
        let timestamp = Date().timeIntervalSince1970
        let hash = "\(timestamp)\(environment.privateKey)\(environment.publicKey)".hashed(.md5)!
        
        
        var requestQueryItems = queryItems
        
        requestQueryItems.append(contentsOf: [
            URLQueryItem(name: "ts", value: String(timestamp)),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: environment.publicKey),])
        
        var urlComponents = URLComponents(string: ulrString)!
        urlComponents.queryItems = requestQueryItems
        
        let requestUrl = URLRequest(url: urlComponents.url!)
        
        let task = session.dataTask(with: requestUrl) { (data, urlResponse, error) in
            guard nil == error else {
                completion (nil, error!)
                return
            }
            if let _ = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!) as T
                    completion(response, nil)
                } catch let error{
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    
}
