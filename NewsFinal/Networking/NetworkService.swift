//
//  NetworkService.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 02.11.2021.
//

import Foundation


protocol Networking {
    func request(url: URL, completion: @escaping (Result<Data?, Error>) -> Void)
}


class NetworkService: Networking {
    
    func request(url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        let request = URLRequest(url: url)
        let tast = createDataTask(from: request, completion: completion)
        tast.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _ , error in
            if let error = error {
                completion(.failure(error))
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}

