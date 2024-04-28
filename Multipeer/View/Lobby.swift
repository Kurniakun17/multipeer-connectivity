//
//  Lobby.swift
//  Multipeer
//
//  Created by Kurnia Kharisma Agung Samiadjie on 27/04/24.
//

import SwiftUI

struct Lobby: View {
    @EnvironmentObject var game: GameService
    @State var selectedChar: String
    @StateObject var connectionManager: MPConnectionManager

    init(selectedChar: String) {
        self.selectedChar = selectedChar
        _connectionManager = StateObject(wrappedValue: MPConnectionManager(yourName: selectedChar))
    }

    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            HStack {
                UserCharacter(imgName: connectionManager.myPeerId.displayName, selectedChar: $selectedChar, isSheetOpen: .constant(false))
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(20)
                    .frame(width: 140, height: 140)

                HStack(spacing: 12) {
                    if connectionManager.availablePeers.count == 0 {
                        Text("Waiting for players...")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 12)
                    }
                    ForEach(connectionManager.availablePeers, id: \.self) {
                        peer in
                        Button(action: {
//                            If peer character was the same, then don't play
                            
                            game.setupScreen(phase: .game)
                            connectionManager.nearbyServiceBrowser.invitePeer(peer, to: connectionManager.session, withContext: nil, timeout: 30)
                        }) {
                            Image(peer.displayName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .alert("Received Invitation from \(connectionManager.receivedInviteFrom?.displayName ?? "Unknown")", isPresented: $connectionManager.receivedInvite) {
                    Button("Accept") {
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(true, connectionManager.session)
                        }
                    }
                }
                .padding()
                .frame(height: 140)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(24)
                .padding(.leading, 20)
            }
        }
        .onAppear {
            connectionManager.setup(game: game)
            connectionManager.isAvailableToPlay = true
            connectionManager.startBrowsing()
        }
        .onDisappear {
            connectionManager.stopBrowsing()
            connectionManager.stopAdvertising()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Lobby(selectedChar: "red_user")
            .environmentObject(MPConnectionManager(yourName: "Sample"))
            .environmentObject(GameService())
    }
}
