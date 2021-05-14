//
//  Message.swift
//  Messenger
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import Foundation

enum MessageType: String {
    case sent
    case received
}

struct Message {
    let text: String
    let type: MessageType
    let created: String
}
