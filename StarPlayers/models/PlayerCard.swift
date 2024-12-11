import SwiftUI

struct PlayerCard: Hashable{
    var playerID: Int
    var playerName: String
    var jerseyNum: String
    var team: String
    var position: String
    
    // fill in stats only when user selects player
    var ppg: Float?
    var rpg: Float?
    var apg: Float?
    var tov: Float?
    
    var fgp: Float?
    var tpp: Float?
    var ftp: Float?
    
}

extension PlayerCard {
    static let sampleData: [PlayerCard] =
    [
        PlayerCard(playerID: 0, playerName: "Jalen Bruson", jerseyNum: "11", team: "New York Knicks", position: "G"),
    ]
}
