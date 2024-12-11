import SwiftUI

class RetrievePlayers: ObservableObject {
    static let shared = RetrievePlayers()
    
    @Published
    var isLoading = false
    
    @Published
    var errorMessage: String?
    
    @Published
    var searchResults: [PlayerCard]
    
    private let apiKey = Secrets.apiKey
    var apiEndpoint: String
    
    private init() {
        searchResults = []
        apiEndpoint = ""
    }
    
    
    func searchPlayer() {
        guard let url = URL(string: apiEndpoint) else {
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(APIResponse.self, from: data)
                    
                    
                    self.searchResults = decodedData.data.map {player in
                        PlayerCard(
                            playerID: player.id,
                            playerName: "\(player.FN) \(player.LN)",
                            jerseyNum: player.JN,
                            team: player.team.teamName,
                            position: player.POS
                        )
                        
                    }
                } catch {
                    /*
                     The API sometimes gives players/results with null values.
                     To ensure relevant data is being displayed, we will filter the draft year
                     so that the player must be drafted by 2003
                     EDIT: author provided API for active players only
                     */
                    debugPrint("Decoding error: \(error)")
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
            
        }.resume()
    }
    func getPlayerStats(playerID: Int, completion: @escaping (PlayerStats?) -> Void) { // function to get and update a players stats for their card
        let url = "https://api.balldontlie.io/v1/season_averages?season=2024&player_id=\(playerID)"
        print(url)
        guard let url = URL(string: url) else {
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                   self.isLoading = false
            }
            if let error = error {
                self.errorMessage = "Error: \(error.localizedDescription)"
                return
            }
            
            guard let data = data else {
                self.errorMessage = "No data received"
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let statsResponse = try decoder.decode(StatsResponse.self, from: data)
                
                if let playerStats = statsResponse.data.first {
                    completion(playerStats)
                } else {
                    completion(nil)
                }
            } catch {
                print ("Error decoding stats response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
}
