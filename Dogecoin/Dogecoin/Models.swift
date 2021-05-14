//
//  Models.swift
//  Dogecoin
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import Foundation

public struct CoinModel: Codable {
    let id: String
    let name: String
    let image: [String: String]
    let market_data: MarketData
    let symbol: String
    let description: [String: String]
    let genesis_date: String
    let last_updated: String
}

public struct MarketData: Codable {
    let current_price: [String: Float]
}
