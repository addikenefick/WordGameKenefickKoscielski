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
    @State var selectedPage = "home"
    @AppStorage("playerName") var playerName = ""
    var ref = Database.database().reference()
    
    @State var exists = false

    var body: some View {
        NavigationStack {
            VStack {
               
//                Spacer()
//                if playerName != "" {
//                                Text("Hi \(playerName)!")
//                                    .font(.title3)
//                                Text("High Score: \(personalHighScore)")
//                                    .font(.headline)
//                                    .foregroundColor(.gray)
//                            }
                if selectedPage == "play" {
                    PlayView(players: $leaderboard, personalHighscore: $personalHighScore)
                        } else if selectedPage == "settings" {
                            SettingsView()
                        } else {
                            VStack {
                                Text("Word Game")
                                    .font(.largeTitle)
                                    .bold()
                                    .fontDesign(.serif)
                                
                                if playerName != "" {
                                    Text("Hi \(playerName)!")
                                    Text("High Score: \(personalHighScore)")
                                        .foregroundColor(.gray)
                                }
                                else {
                                    Text("Playing as guest")
                                }
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                selectedPage = "home"
                            } label: {
                                VStack {
                                    Image(systemName: "house")
                                    Text("Home")
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                selectedPage = "play"
                            } label: {
                                VStack {
                                    Image(systemName: "gamecontroller")
                                    Text("Play")
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                selectedPage = "settings"
                            } label: {
                                VStack {
                                    Image(systemName: "gear")
                                    Text("Settings")
                                }
                            }
                        }
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.lightgray)
                        .clipShape(RoundedRectangle(cornerRadius: 15))

//                NavigationLink("View Leaderboard") {
//                    LeaderboardView(scores: $leaderboard)
//                }
//                .bold()
//                .frame(width: 155, height: 40)
//                .background(.black)
//                .foregroundColor(.white)
//                .clipShape(RoundedRectangle(cornerRadius: 15))
//                .padding()
//                .shadow(radius: 3)
            }
            .padding()
            .onAppear(){
                leaderboard.removeAll()
                firebaseStuff()
                if playerName == "" {
                        showName = true
                }
            }
            /*.alert("Enter Your Name", isPresented: $showName) {
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
            }*/
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


