//
//  DetailView.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//

import SwiftUI


struct Detailview: View {
    let user: CatchUser
    let rows = [
        GridItem(.adaptive(minimum: 30))
    ]
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 2) {
                Image("FaceImage")
                    .resizable()
                    .frame(width: 150, height: 130)
                    .clipShape(Circle())
                Text(user.wrappedName)
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                Text(user.wrappedEmail)
                    .font(.headline)
                    .foregroundColor(Color(.systemGreen))
                
                List {
                    Section {
                        Text(user.wrappedAbout)
                    } header: {
                        Text("About")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 8 )
                            .fill(Color.white.opacity(0.35))
                    )
                    
                    Section {
                        Text("Age: \(user.age)")
                        Text("Company: \(user.wrappedCompany)")
                        Text("Registred: \(user.wrappedRegistred)")
                    }header: {
                        Text("Information")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(
                        Color.white.opacity(0.35)
                    )
                    
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows) {
                                ForEach(user.friendsArray) {friend in
                                    HStack(spacing: 8) {
                                        Image(systemName: "person.fill")
                                        Text(friend.wrappedName)
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                    } header: {
                        Text("Friends")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .listRowBackground(
                        Color.white.opacity(0.35)
                    )
                }
                .scrollContentBackground(.hidden)
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.8470588235, blue: 0.6078431373, alpha: 1)), Color(#colorLiteral(red: 0.09803921569, green: 0.3294117647, blue: 0.4823529412, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

//struct Detailview_Previews: PreviewProvider {
//    static var previews: some View {
//        Detailview()
//    }
//}
