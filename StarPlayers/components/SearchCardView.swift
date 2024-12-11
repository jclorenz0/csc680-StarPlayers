
import SwiftUI

struct SearchCardView: View {
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
                    }
                    .font(.caption)
                    .padding(.horizontal)
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
            .frame(maxWidth: .infinity)
        }.buttonStyle(PlainButtonStyle()) // removes default button appearance
    }
    
}



struct SearchCard_Preview: PreviewProvider {
    static var player = PlayerCard.sampleData[0]
    static var previews: some View {
        SearchCardView(player: player, onTap: {
            print("Card tapped")
        })
        
    }
}
