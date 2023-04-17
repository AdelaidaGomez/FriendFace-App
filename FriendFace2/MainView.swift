//
//  MainView.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUser: FetchedResults<CatchUser>
    
    @State private var users = [User]()
    @ObservedObject var name: UserName
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 3) {
                Image("Facephoto2")
                    .resizable()
                    .frame(width: 150, height: 200)
                    .clipShape(Circle())
                Text("Hello \(name.name)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                Text("Active")
                    .font(.headline)
                    .foregroundColor(.green)
                List {
                    Section {
                        ForEach(cachedUser) { user in
                            NavigationLink{
                                Detailview(user: user)
                            }label: {
                                HStack(spacing: 20) {
                                    Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(user.isActive ? Color.green : Color.gray)
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(user.wrappedName)
                                            .font(.title2.bold())
                                            .foregroundColor(.black)
                                        Text(user.isActive ? "Active" : "Offline")
                                            .foregroundColor(user.isActive ? Color.green : Color.gray)
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Your Friends")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .headerProminence(.increased)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Capsule()
                            .fill(Color.white.opacity(0.35))
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 8)
                    )
                }
                .scrollContentBackground(.hidden)
            }
            
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8470588235, blue: 0.6078431373, alpha: 1)), Color(#colorLiteral(red: 0.09803921569, green: 0.3294117647, blue: 0.4823529412, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
        }
        .navigationTitle("FriendFace")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if cachedUser.isEmpty {
                if let retrievedUsers = await getUsers() {
                    users = retrievedUsers
                }
                await MainActor.run {
                    for user in users {
                        let newUser = CatchUser(context: moc)
                        newUser.name = user.name
                        newUser.id = user.id
                        newUser.isActive = user.isActive
                        newUser.age = Int16(user.age)
                        newUser.about = user.about
                        newUser.email = user.email
                        newUser.company = user.company
                        //                              newUser.registred = user.registered
                        
                        for friend in user.friends {
                            let newFriend = CatchFriend(context: moc)
                            newFriend.id = friend.id
                            newFriend.name = friend.name
                            newFriend.user = newUser
                        }
                        
                        try? moc.save()
                    }
                }
            }
        }
        
        
    }
    
    func getUsers() async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
}
