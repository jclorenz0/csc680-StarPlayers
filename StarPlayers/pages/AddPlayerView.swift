// View that serves as the "Search for Player" tab

import SwiftUI

struct AddPlayerView: View {
    @State
    private var searchText: String = ""
    
    @State
    private var displaySearchText: String?
    
    @StateObject
    private var retrievePlayers = RetrievePlayers.shared
    
    @Binding
    var selectedPlayers: [PlayerCard]?
    
    @State
    var showAlert: Bool
    
    @State
    var alertMessage: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                Group{
                    Text("1. Search by first name OR last name, not both.")
                    Text("2. Click a player to add them to your list.")
                }.font(.subheadline)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                
                HStack {
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        performSearch()
                    }) {
                        Text("Search")
                            .font(.headline)
                            .padding()
                            .frame(height: 40)
                            .background(.green)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
                
                if let displayText = displaySearchText, !displayText.isEmpty {
                    Text("Displaying results for \"\(displayText)\"")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                if retrievePlayers.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = retrievePlayers.errorMessage {
                    Text("Oops, an error has occurred: \(errorMessage)")
                } else {
                    HStack{
                        List {
                            ForEach(retrievePlayers.searchResults, id: \.playerID) { player in
                                SearchCardView(player: player, onTap: {
                                    if ((selectedPlayers?.contains(where: {$0.playerID == player.playerID})) == true){
                                        print("player already in list")
                                        alertMessage = "\(player.playerName) is already in your list!"
                                        showAlert = true
                                    } else {
                                        selectedPlayers?.append(player)
                                        retrievePlayers.getPlayerStats(playerID: player.playerID) { playerStats in
                                            if let stats = playerStats {
                                                if let index = selectedPlayers?.firstIndex(where: {$0.playerID == player.playerID}) {
                                                    selectedPlayers?[index].ppg = stats.pts
                                                    selectedPlayers?[index].rpg = stats.reb
                                                    selectedPlayers?[index].apg = stats.ast
                                                    selectedPlayers?[index].tov = stats.turnover
                                                    selectedPlayers?[index].fgp = stats.fg_pct * 100
                                                    selectedPlayers?[index].tpp = stats.fg3_pct * 100
                                                    selectedPlayers?[index].ftp = stats.ft_pct * 100
                                                    
                                                    // Show an alert
                                                    alertMessage = "\(player.playerName) has been added with updated stats."
                                                    showAlert = true
                                                }
                                            }
                                            
                                        }
                                    }
                                })
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Add Player")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Player Added"),
                      message: Text(alertMessage ?? "Fix This"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func performSearch(){
        displaySearchText = searchText
        
        retrievePlayers.searchResults = []
        retrievePlayers.errorMessage = nil
//        retrievePlayers.isLoading = false
        
        retrievePlayers.apiEndpoint = "https://api.balldontlie.io/v1/players/active?search=\(searchText)"
        print(retrievePlayers.apiEndpoint)
        retrievePlayers.searchPlayer()
    }
}

