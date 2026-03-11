import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
struct ContentView: View {
    @State var leaderboard: [Player] = []
    @AppStorage("personalHighScore") var personalHighScore = 0
    @State var showName = false
    @State var enteredName = ""
    @AppStorage("playerName") var playerName = ""
    var ref = Database.database().reference()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Word Game")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundColor(.black)
                if playerName != "" {
                                    Text("Hi \(playerName) your highscore is: \(personalHighScore)")
                                        .font(.title3)
                                        .padding()
                                }
                
                NavigationLink("PLAY") {
                    GameView(thisPlayer: $leaderboard, personalHighScore: $personalHighScore)
                 

                }
                
                .bold()
                .frame(width: 130, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                
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
                leaderboard.removeAll()
                firebaseStuff()
                if playerName == "" {
                        showName = true
                    }
            }
            .alert("Enter Your Name", isPresented: $showName) {
                TextField("Name", text: $enteredName)

                Button("Save") {
                    playerName = enteredName
                }
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


