//
//  APICaller.swift
//  NewsApp
//
//  Created by Sabyrzhan Tynybayev on 15.05.2021.
//

import Foundation
import Alamofire

final class APICaller {
    static let shared = APICaller()
    
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Config.local", ofType: "plist") else {
          fatalError("Couldn't find file 'Config.local.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Config.local.plist'.")
        }
        return value
      }
    }
    
    struct Constants {
        static let topHeadlinesURL = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=%@"
        static let searchURL = "https://newsapi.org/v2/top-headlines?q=%@&country=us&category=technology&apiKey=%@"
    }
    
    private init() {
        
    }
    
    public func getTopStories(completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        let urlString = String(format: Constants.topHeadlinesURL, apiKey)
        guard let url = URL(string: urlString) else {
            return
        }
        
        makeQuery(url: url, completion: completion)
    }
    
    public func searchTopStories(query: String, completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        let urlString = String(format: Constants.searchURL, query, apiKey)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        makeQuery(url: url, completion: completion)
    }
    
    private func makeQuery(url: URL, completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        AF.request(url).responseDecodable(of: NewsResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            } else if let newsResponse = response.value {
                completion(.success(newsResponse.articles))
            }
        }
    }
    
    
}

private class NewsResponse: Codable {
    public let articles: [NewsModel]
}
