import SwiftUI

struct ContentView: View {
    @State
    var showTabView: Bool = false // state to toggle between tabview and landing page
    
    @State
    private var selectedTab = 0 // keeps track of selected tab
    
    @State
    var selectedPlayers: [PlayerCard]? = []
    
    var body: some View {
            if showTabView {
                TabView(selection: $selectedTab) {
                    CardListView(selectedTab: $selectedTab, selectedPlayers: $selectedPlayers)
                        .tabItem {
                            Image(systemName: "person.3.fill")
                            Text("Player List")
                        }
                        .tag(0)
                    
                    
                    AddPlayerView(selectedPlayers: $selectedPlayers, showAlert: false)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search for Player")
                        }
                        .tag(1)
                    
                    AboutUsView()
                        .tabItem {
                            Image(systemName: "info.circle.fill")
                            Text("About Us")
                        }
                    
                }
            } else {
                WelcomeView(showTabView: $showTabView)
            }
        
        
    }
}
#Preview {
    ContentView()
}
