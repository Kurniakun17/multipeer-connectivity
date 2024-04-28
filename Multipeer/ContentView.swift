//
//  ContentView.swift
//  Multipeer
//  Created by Kurnia Kharisma Agung Samiadjie on 27/04/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = GameService()
    @State var selectedChar: String = "red_user"
    @State var isSheetOpen = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                VStack {
                    SelectCharacter(isSheetOpen: $isSheetOpen, selectedChar: $selectedChar)
                    NavigationLink {
                        Lobby(selectedChar: selectedChar)
                    } label: {
                        Image("play")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .padding(.top)
                    }
                }
            }
        }
        .environmentObject(game)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
