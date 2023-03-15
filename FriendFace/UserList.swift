//
//  UserList.swift
//  FriendFace
//
//  Created by Matheus Viana on 14/03/23.
//

import SwiftUI

struct UserList: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    /*@START_MENU_TOKEN@*/Text(user.name)/*@END_MENU_TOKEN@*/
                }
            }
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
                        
            let decodedUser = try JSONDecoder().decode([User].self, from: data)
            
            users = decodedUser
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}
