import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
struct ContentView: View {
    @State var leaderboard: [Player] = []
    var ref = Database.database().reference()
    var body: some View {
        NavigationStack {
            VStack {
                Text("Word Game")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundColor(.black)
                
                NavigationLink("PLAY") {
                    GameView(thisPlayer: $leaderboard)
                }
                .bold()
                .frame(width: 130, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                .navigationBarBackButtonHidden(false)
                
                Spacer()
                NavigationLink("View Leaderboard") {
                    LeaderboardView(scores: leaderboard)
                }
                .bold()
                .frame(width: 150, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            }
            
            .padding()
            .onAppear(){
                firebaseStuff()
            }
        }
    }
    func firebaseStuff() {
        ref.child("leaderboard").observe(.childAdded) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                let player = Player(snapshot: value)
                player.key = snapshot.key
                leaderboard.append(player)
            }
        }
    }
}


