import SwiftUI

struct AboutUsView: View {
    
    let displayText: String = "As a working college student, it's difficult to find time for my personal interests during the year, especially watching professional basketball. I was tired of tediously traversing other sports-related applications to find simple statistics. My goal was to create an application where I can quickly and effortlessly keep track of my favorite players' performance throughout the season. I hope to extend this to team statictics in the future and add more QoL features to enhance the user experience."
    
    var body: some View {
        VStack{
            Text("Our mission")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            Divider()
            
            Text(displayText)
                .padding()
            
            Divider()
//            Spacer()
            Text("Developer's Socials")
                .font(.title2)
                .bold()
                .padding(.top, 20)
            VStack {
                SocialMediaLink (
                    platform: "Instagram",
                    username: "@jc.dmg",
                    url: URL(string: "https://www.instagram.com/jc.dmg/")!,
                    iconName: "camera.fill"
                ).padding(.horizontal)
                SocialMediaLink (
                    platform: "LinkedIn",
                    username: "Jaycee Lorenzo",
                    url: URL(string: "https://www.linkedin.com/feed/")!,
                    iconName: "person.fill"
                ).padding(.horizontal)
                SocialMediaLink (
                    platform: "GitHub",
                    username: "jclorenz0",
                    url: URL(string: "https://github.com/jclorenz0")!,
                    iconName: "terminal.fill"
                ).padding(.horizontal)
            }
            Spacer()
        }
        
    }
}


struct SocialMediaLink: View {
    let platform: String
    let username: String
    let url: URL
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(platform)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(username)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Link(destination: url) {
                Text("Visit")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    AboutUsView()
}
