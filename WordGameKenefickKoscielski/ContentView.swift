import SwiftUI
import GoogleSignIn
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
    
    @State var exists = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Word Game")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.serif)
                    .foregroundColor(.black)
                Spacer()
                if playerName != "" {
                                Text("Hi \(playerName)!")
                                    .font(.title3)
                                Text("High Score: \(personalHighScore)")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }

                
                NavigationLink("PLAY") {
                    GameView(thisPlayer: $leaderboard, personalHighScore: $personalHighScore)
                 

                }
                
                .bold()
                           .frame(maxWidth: .infinity)
                           .frame(height: 50)
                           .background(Color.black)
                           .foregroundColor(.white)
                           .clipShape(RoundedRectangle(cornerRadius: 14))
                           .shadow(radius: 3)
                           .padding()
                
                Spacer()
                NavigationLink("View Leaderboard") {
                    LeaderboardView(scores: $leaderboard)
                }
                .bold()
                .frame(width: 155, height: 40)
                .background(.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                .shadow(radius: 3)

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
                    if leaderboard.contains(where: { $0.name == enteredName }) == false {
                        playerName = enteredName
                    }
                    else {
                        exists = true
                    }
                }
            }
            
            .alert("Name Already Taken", isPresented: $exists) {
                Button("Okay") {
                    exists = false
                    enteredName = ""
                    showName = true
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
    
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        if error != nil || user == nil {
          // Show the app's signed-out state.
        } else {
          // Show the app's signed-in state.
        }
      }
      return true
    }
}


