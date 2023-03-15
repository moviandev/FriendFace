//
//  ContentView.swift
//  FriendFace
//
//  Created by Matheus Viana on 13/03/23.
//

import SwiftUI

struct ContentView: View {
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
