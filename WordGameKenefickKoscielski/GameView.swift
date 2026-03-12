//
//  GameView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 2/20/26.
//

import SwiftUI
import FirebaseDatabaseInternal

struct GameView: View {
    @Binding var thisPlayer: [Player]
    @AppStorage("playerName") var playerName = ""
    @Binding var personalHighScore: Int
    @State var thisPoints = ""
    @State var newScore = false
    @State var addedName = ""
    @State var consonantLetters: [String] = []
    
    @State var vowelLetters: [String] = []
    
    @State var word = " "
    
    @State var vowels = ["A","E","I","O","U"]
    
    @State var consonants = [
        "B","C","D","F","G","H","J","K","L","M",
        "N","P","Q","R","S","T","V","W","X","Y","Z"]
    
    @State var points = 0
    @State var notReal = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State var over30 = true
    
    @State var over50 = true
    
    @State var wordsPlayed: [String] = []
    
    @State var alreadyPlayed = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Button("End Game") {
                    
                    thisPoints = "\(points)"
                    
                    if points > personalHighScore {
                        personalHighScore = points
                        newScore = true
                    } else {
                        dismiss()
                    }
                }
                .padding(10)
                .frame(alignment: .leading)
                .background(.red)
                .foregroundStyle(.white)
                .cornerRadius(10)
                
                Spacer()
                Text("Points: \(points)")
                                   .bold()
                                   .padding()
                                   .font(.title)
                               Text("Shop:")
                                   .bold()
                               HStack {
                                   NavigationLink("Consonant \n(30 Points)", destination: NewLetterView(changeLetters: $consonantLetters, points: $points, vor: 1))
                                   .padding(10)
                                   .background(.black)
                                   .foregroundStyle(.white)
                                   .cornerRadius(10)
                                   .navigationBarBackButtonHidden(true)
                                   .disabled(over30)
                                   
                                   NavigationLink("Vowel \n(50 Points)", destination: NewLetterView(changeLetters: $vowelLetters, points: $points, vor: 2))
                                   .padding(10)
                                   .background(.blue)
                                   .foregroundStyle(.white)
                                   .cornerRadius(10)
                                   .navigationBarBackButtonHidden(true)
                                   .disabled(over50)
                               }

                
                Spacer()
                Text(" \(word) ")
                    .font(.system(size: 40, weight: .bold))
                                      .frame(maxWidth: .infinity)
                                      .frame(height: 60)
                                      .background(Color.gray.opacity(0.2))
                                      .clipShape(RoundedRectangle(cornerRadius: 12))
                                      .padding()
                HStack {
                    ForEach(consonantLetters, id: \.self) { letter in
                        Button(letter) {
                            word += letter
                        }
                        .padding()
                                              .frame(maxWidth: .infinity)
                                              .background(Color.black)
                                              .foregroundColor(.white)
                                              .clipShape(RoundedRectangle(cornerRadius: 12))
                                              .shadow(radius: 3)
                    }
                }
                
                HStack {
                    ForEach(vowelLetters, id: \.self) { letter in
                        Button(letter) {
                            word += letter
                        }
                        .padding()
                                           .frame(maxWidth: 67)
                                           .background(Color.blue)
                                           .foregroundColor(.white)
                                           .clipShape(RoundedRectangle(cornerRadius: 12))
                                           .shadow(radius: 3)
                    }
                }
                Spacer()
                
                Button("Submit") {
                    print(word)
                    getDictionary(theWord: word)
                    word = ""
                }
                .padding(10)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 3)

                HStack{
                    Button("Delete"){
                        if !word.isEmpty{
                            word.removeLast()
                        }
                    }
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)

                    Button("Clear"){
                        word = ""
                    }
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)

                }
                
            }
            .alert("New Highscore!", isPresented: $newScore) {
                Button("yay") {
                    let ref = Database.database().reference()

                    if let existingPlayer = thisPlayer.first(where: { $0.name == playerName }) {

                        ref.child("leaderboard").child(existingPlayer.key).updateChildValues([
                            "score": thisPoints
                        ])
                        
                        existingPlayer.score = thisPoints

                    } else {

                        let newRef = ref.child("leaderboard").childByAutoId()
                        
                        newRef.setValue([
                            "name": playerName,
                            "score": thisPoints
                        ])
                        
                        let newPlayer = Player(name: playerName, score: thisPoints)
                        newPlayer.key = newRef.key ?? ""
                        
                        thisPlayer.append(newPlayer)
                    }
                    dismiss()
                }
            }
            
            .onAppear() {
                if vowelLetters.isEmpty && consonantLetters.isEmpty {
                    generateLetters()
                }
                over()
            }
            
            .alert("Not a real word", isPresented: $notReal) {
                
            }
            
            .alert("Already played this word", isPresented: $alreadyPlayed) {
                
            }
        }
    }
    
    func generateLetters() {
        let shuffledConsonants = consonants.shuffled()
        consonantLetters = Array(shuffledConsonants.prefix(6))
        
        let shuffledVowels = vowels.shuffled()
        vowelLetters = Array(shuffledVowels.prefix(3))
        
        word = ""
    }
    
    func over() {
        if points >= 30 {
            over30 = false
            if points >= 50 {
                over50 = false
            }
            else {
                over50 = true
            }
        } else {
            over30 = true
            over50 = true
        }
    }
    
    func getDictionary(theWord: String) {
        
        let session = URLSession.shared
        
        let dictionaryURL = URL(string: "https://dictionaryapi.com/api/v3/references/collegiate/json/\(theWord)?key=587f7e0d-5c50-4769-a331-613f3d481f68")!
        
        let dataTask = session.dataTask(with: dictionaryURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error: \(error)")
            } else {
                if let data = data {
                    //print("\(data)")
                    //print(data)
                    if (try? JSONSerialization.jsonObject(with: data) as? [NSDictionary]) != nil {
                        //print(jsonObj.count)
                        //print(jsonObj[0])
                        
                        if wordsPlayed.contains(theWord) {
                            alreadyPlayed = true
                        } else {
                            points += theWord.count
                            
                            if points >= 30 {
                                over30 = false
                                if points >= 50 {
                                    over50 = false
                                } else {
                                    over50 = true
                                }
                            } else {
                                over30 = true
                                over50 = true
                            }
                            
                            wordsPlayed.append(theWord)
                        }
                        
                        //if let y = jsonObj[0]["date"] as? String {
                            //print(y)
                        //}
                        
                    } else {
                        notReal = true
                        //print("Error: unable to convert json object")
                    }
                } else {
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }
}

