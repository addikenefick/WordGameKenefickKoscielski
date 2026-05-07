import SwiftUI
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

struct ContentView: View {
    @State var leaderboard: [Player] = []
    @AppStorage("easyHigh") var easyHigh = 0
    @AppStorage("mediumHigh") var mediumHigh = 0
    @AppStorage("hardHigh") var hardHigh = 0
    @State var showName = false
    @State var enteredName = ""
    @State var selectedPage = "home"
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
                    PlayView(players: $leaderboard, easyHigh: $easyHigh, mediumHigh: $mediumHigh, hardHigh: $hardHigh)
                        } else if selectedPage == "settings" {
                            SettingsView()
                        } else {
                            VStack {
                                Text("Word Game")
                                    .font(.largeTitle)
                                    .bold()
                                    .fontDesign(.serif)
                                
                             
                                Spacer()
                                NavigationLink("Easy High Scores") {
                                    LeaderboardView(scores: $leaderboard, selectedMode: 1)
                                }
                                .padding()
                                .background(.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                NavigationLink("Medium High Scores") {
                                    LeaderboardView(scores: $leaderboard, selectedMode: 2)
                                }
                                .padding()
                                .background(.yellow)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                                NavigationLink("Hard High Scores") {
                                    LeaderboardView(scores: $leaderboard, selectedMode: 3)
                                }
                                .padding()
                                .background(.red)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
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

#Preview {
    ContentView()
}


