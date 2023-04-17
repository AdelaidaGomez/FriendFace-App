//
//  ContentView.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(4)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
                    .frame(width: 170, height: 35)
            }
    }
}


class UserName: ObservableObject {
    @Published var name = ""
}

struct ContentView: View {
    @State private var name = UserName()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Image2")
                    .resizable()
                    .ignoresSafeArea(.all)
                ZStack {
                    Color.white.opacity(0.35)
                        .frame(width: 300, height: 310)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    
                    VStack(spacing: 20) {
                        Text("Hello There")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color.black.opacity(0.8))
                        
                        Text("Enter your name")
                        TextField("", text: $name.name)
                            .textFieldStyle(OutlinedTextFieldStyle())
                            .padding(.horizontal, 128)
                            .foregroundColor(.black)
                        
                        NavigationLink {
                            MainView(name: name)
                        }label: {
                            Image(systemName: "greaterthan.circle")
                                .resizable()
                                .padding(.vertical, 4)
                                .frame(width: 37, height: 43)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
