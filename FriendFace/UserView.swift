//
//  UserList.swift
//  FriendFace
//
//  Created by Matheus Viana on 14/03/23.
//

import SwiftUI

struct UserView: View {
    var user: User
    var users: [User]
    
    var body: some View {
        Form {
            Section("Registered in") {
                Text("\(user.registered.formatted(date: .complete, time: .omitted))")
            }
            
            Section("Age") {
                Text("\(user.age) years old")
            }
            
            Section("Works at") {
                Text(user.company)
            }
            
            Section("Email") {
                Text(user.email)
            }
            
            Section("Address") {
                Text(user.address)
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("They like") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            
            Section("They are friend with") {
                ForEach(user.friends) { friend in
                    NavigationLink {
                        UserView(user: users.first(where: {$0.id == friend.id}) ?? user, users: users)
                    } label: {
                        Text(friend.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationTitle(user.titleName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserList_Previews: PreviewProvider {
    static let user = User(id: UUID(), isActive: true, name: "Test", company: "test company", age: 20, email: "test@test", address: "test address", about: "test about", registered: Date.now, tags: ["test", "test"], friends: [Friend]())
    
    static var previews: some View {
        UserView(user: user, users: [User]())
    }
}
