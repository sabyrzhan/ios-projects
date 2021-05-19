//
//  Message.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import Foundation

enum MessageType: String, Codable {
    case sent
    case received
}

struct Message: Hashable, Codable {
    var text: String
    var type: MessageType
    var created: Date
}
