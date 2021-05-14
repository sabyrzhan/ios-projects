//
//  News.swift
//  NewsApp
//
//  Created by Sabyrzhan Tynybayev on 15.05.2021.
//

import Foundation

final class NewsModel: Codable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
