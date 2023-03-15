//
//  ContentView.swift
//  FriendFace
//
//  Created by Matheus Viana on 13/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            UserList()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
