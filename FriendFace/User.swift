//
//  User.swift
//  FriendFace
//
//  Created by Matheus Viana on 13/03/23.
//

import Foundation

struct User: Identifiable, Codable {    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
