import SwiftUI

struct CardListView: View {
    @Binding
    var selectedTab: Int // binding to switch tabs
    
    @Binding
    var selectedPlayers: [PlayerCard]?
    
    @State
    private var showDeleteConfirmation: Bool = false
    
    @State
    private var playerToRemove: PlayerCard? = nil
    
    @State
    private var showAlert: Bool = false // alert to delete player from list
    
    
    var body: some View {
        NavigationStack {
            Text("2024-25 Season")
                .padding(.bottom, 0)
                .padding(.horizontal)
                .italic()
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            List {
                if let players = selectedPlayers, !players.isEmpty {
                    ForEach(players, id: \.self) { player in
                        CardView(player: player, onTap: {
                            playerToRemove = player
                            showAlert = true
                        })
                    }
                } else {
                    HStack {
                        Text("No players selected. Search players to add.")
                            .italic()
                            .font(.subheadline)
                    }
                }
                HStack { // add player button
                    Spacer()
                    Button(action: {
                        selectedTab = 1 // switch tab to search player
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Player")
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .cornerRadius(6)
                        .fontWeight(.semibold)
                    }
                    Spacer()
                }
                
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Remove player"),
                    message: Text("Are you sure you want to remove \(playerToRemove?.playerName ?? "this player")"),
                    primaryButton: .destructive(Text("Remove")) {
                        if let player = playerToRemove {
                            selectedPlayers?.removeAll{$0 == player}
                        }
                    },
                    secondaryButton: .cancel()
                    
                )
            }
            .navigationTitle("StarPlayers")
        }
            .padding(0)
    }
    
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(selectedTab: .constant(0), selectedPlayers: .constant(nil))
    }
}


