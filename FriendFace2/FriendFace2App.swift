//
//  FriendFace2App.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//

import SwiftUI

@main
struct FriendFace2App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
