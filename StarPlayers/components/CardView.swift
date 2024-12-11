import SwiftUI

struct CardView: View {
    let player: PlayerCard
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack {
                VStack {
                    Text(player.playerName) // player name
                        .font(.headline)
                        .bold()
                    
                    HStack (spacing: 2){ // team and jersey number
                        Text(player.team) // team
                        Text("|")
                            .italic()
                        HStack (spacing: 1) { // jersey num
                            Text("#")
                            Text(player.jerseyNum)
                        }
                        Text("|")
                            .italic()
                        Text(player.position) // position
                    }.font(.caption)
                    
                    Divider()
                        .padding(.vertical, 0)
                    
                    // STATS SECTION
                    HStack {
                        HStack (spacing: 2) {
                            Text("PPG:")
                            Text(String(format: "%.1f", player.ppg ?? 0.0)).fontWeight(.semibold)
                        }
                        HStack (spacing: 2) {
                            Text("RPG:")
                            Text(String(format: "%.1f", player.rpg ?? 0.0)).fontWeight(.semibold)
                        }
                        HStack (spacing: 2) {
                            Text("APG:")
                            Text(String(format: "%.1f", player.apg ?? 0.0)).fontWeight(.semibold)
                        }
                        HStack (spacing: 2) {
                            Text("TOV:")
                            Text(String(format: "%.1f", player.tov ?? 0.0)).fontWeight(.semibold)
                        }
                    }
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    
                    HStack {
                        HStack (spacing: 2) {
                            Text("FG%:")
                            Text(String(format: "%.1f", player.fgp ?? 0.0)).fontWeight(.semibold)
                        }
                        HStack (spacing: 2) {
                            Text("3PT%:")
                            Text(String(format: "%.1f", player.tpp ?? 0.0)).fontWeight(.semibold)
                        }
                        HStack (spacing: 2) {
                            Text("FT%:")
                            Text(String(format: "%.1f", player.ftp ?? 0.0)).fontWeight(.semibold)
                        }
                    }
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                }
                
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            )
        }.buttonStyle(PlainButtonStyle()) // removes default button appearance
    }
    
}



struct CardView_Previews: PreviewProvider {
    static var player = PlayerCard.sampleData[0]
    static var previews: some View {
        CardView(player: player, onTap: {
            print("Card tapped")
        })
        
    }
}
