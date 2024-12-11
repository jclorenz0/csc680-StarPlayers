import SwiftUI

struct WelcomeView: View {
    @Binding
    var showTabView: Bool
    
    var body: some View {
        VStack {
            Text("StarPlayers")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            Text("A simple solution to keep track of your favorite NBA players!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom)
            Button("Start Tracking") {
                showTabView = true
            }
                .padding()
                .background(.green)
                .foregroundColor(.black)
                .cornerRadius(8)
                .shadow(radius: 1)
                
        }
        
    }
}
