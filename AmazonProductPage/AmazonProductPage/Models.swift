//
//  Models.swift
//  AmazonProductPage
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import Foundation

public struct ProductDetails {
    let description: String
    let images: [String]
    let price: Float
    let relatedProducts:[ProductDetails]
}
