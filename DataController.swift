//
//  DataController.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendFace")
    
    init() {
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Core Data faild to load: \(error.localizedDescription)")
            }
        }
    }
}
