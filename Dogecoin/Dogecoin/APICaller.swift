//
//  APICaller.swift
//  Dogecoin
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    static let GET_DOGECOIN_URL = "https://api.coingecko.com/api/v3/coins/dogecoin"
    
    private init() {}
    
    public func getDogecoin(completion: @escaping (Result<CoinModel, Error>) -> Void) {
        var urlRequest = URLRequest(url: URL(string: Self.GET_DOGECOIN_URL)!)
        urlRequest.addValue("PostmanRuntime/7.26.8", forHTTPHeaderField: "User-Agent")
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CoinModel.self, from: data)
                return completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
