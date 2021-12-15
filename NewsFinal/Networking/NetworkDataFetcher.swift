//
//  NetworkDataFetcher.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 02.11.2021.
//

import Foundation

protocol DataFetcher {
    func fetchJSONData<T: Codable>(url: URL, response: @escaping (Result<T?, Error>) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchJSONData<T: Codable>(url: URL, response: @escaping (Result<T?, Error>) -> Void) {
        networking.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                let decoded = self?.decodeJSON(type: T.self, from: data)
                response(.success(decoded))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    private func decodeJSON<T: Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch {
            print(error)
            return nil
        }
    }
}
