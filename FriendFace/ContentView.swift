//
//  ContentView.swift
//  FriendFace
//
//  Created by Matheus Viana on 13/03/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    @FetchRequest(sortDescriptors: []) var cachedFriends: FetchedResults<CachedFriend>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserView(user: user, users: users)
                    } label: {
                            HStack {
                                Text(user.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(user.age, format: .number)
                                    .font(.headline)
                                    .foregroundColor(.primary.opacity(0.5))
                                
                                Spacer()
                                Spacer()
                                
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(user.isActive ? .green.opacity(0.7) : .gray.opacity(0.5))
                            }
                            .padding()
                        }
                }
                .navigationTitle("FriendFace")
            }
            .preferredColorScheme(.dark)
            .onAppear {
                Task {
                    await fetchUserData()
                    await MainActor.run {
                        for user in users {
                            var newUser = CachedUser(context: moc)
                            newUser.name = user.name
                            newUser.company = user.company
                            newUser.registered = user.registered
                            newUser.address = user.address
                            newUser.id = user.id
                            newUser.email = user.email
                            newUser.isActive = user.isActive
                            newUser.age = Int16(user.age)
                            newUser.about = user.about
                            
                            var friends = Set<CachedFriend>()
                            
                            for friend in user.friends {
                                var newFriend = CachedFriend(context: moc)
                                
                                newFriend.name = friend.name
                                newFriend.id = friend.id
                                
                                friends.insert(newFriend)
                            }
                            
                            newUser.addToCachedFriends(friends as NSSet)
                            
                            if moc.hasChanges {
                                try! moc.save()
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    func fetchUserData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let decodedUser = try decoder.decode([User].self, from: data)
            
            users = decodedUser
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
