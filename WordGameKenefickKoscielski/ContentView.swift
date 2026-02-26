import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Word Game")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundColor(.black)
                
                NavigationLink("PLAY") {
                    GameView()
                }
                .bold()
                .frame(width: 130, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                Spacer()
                NavigationLink("View Leaderboard") {
                    LeaderboardView(scores: [])
                }
                .bold()
                .frame(width: 80, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            }
            
            .padding()
        }
    }
}
