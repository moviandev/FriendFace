//
//  Friend.swift
//  FriendFace
//
//  Created by Matheus Viana on 14/03/23.
//

import Foundation

struct Friend: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
}
