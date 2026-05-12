//
//  GameView.swift
//  WordGameKenefickKoscielski
//
//  Created by SAMANTHA KOSCIELSKI on 2/20/26.
//

import FirebaseDatabaseInternal
import FlowLayout
import SwiftUI

struct GameView: View {
    @Binding var thisPlayer: [Player]
    @Binding var easyHigh: Int
    @Binding var mediumHigh: Int
    @Binding var hardHigh: Int
    @State var thisPoints = ""
    @State var newScore = false
    @State var addedName = ""
    @State var consonantLetters: [String] = []

    @State var vowelLetters: [String] = []

    @State var word = " "

    @State var vowels = ["A", "E", "I", "O", "U"]

    @State var consonants = [
        "B", "C", "D", "F", "G", "H", "J", "K", "L", "M",
        "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z",
    ]

    @State var points = 100
    @State var notReal = false

    @Environment(\.dismiss) private var dismiss

    @State var over30 = true

    @State var over50 = true

    @State var amtOfLetters = false

    @State var wordsPlayed: [String] = []

    @State var alreadyPlayed = false

    @State var gamemode: Int
    @State var currentHigh = 0

    @State var columns1 = Array(
        repeating: GridItem(.fixed(67), spacing: 10),
        count: 4
    )

    @State var columns2 = Array(
        repeating: GridItem(.fixed(67), spacing: 10),
        count: 3
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Button("End Game") {
                    if topHundred() {
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
                    VStack {
                        NavigationLink("Consonant") {
                            NewLetterView(
                                difficulty: $gamemode,
                                changeLetters: $consonantLetters,
                                points: $points,
                                vor: 1
                            )
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding(10)
                        .background(.black)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .disabled(over30)
                        Text("30 Points")
                    }
                    VStack {
                        NavigationLink("Vowel") {
                            NewLetterView(
                                difficulty: $gamemode,
                                changeLetters: $vowelLetters,
                                points: $points,
                                vor: 2
                            )
                            .navigationBarBackButtonHidden(true)
                        }
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .disabled(over50)
                        Text("50 Points")

                    }
                }
                Spacer()
                Text(" \(word) ")
                    .font(.system(size: 40, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()

                if gamemode == 1 {

                    LazyVGrid(columns: columns1, spacing: 10) {
                        ForEach(consonantLetters, id: \.self) { letter in
                            Button(letter) {
                                word += letter
                            }
                            .padding()
                            .frame(width: 67, height: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 3)
                        }
                    }

                } else {
                    if gamemode == 2 {
                        LazyVGrid(columns: columns2, spacing: 10) {
                            ForEach(consonantLetters, id: \.self) { letter in
                                Button(letter) {
                                    word += letter
                                }
                                .padding()
                                .frame(width: 67, height: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 3)
                            }
                        }
                    } else {
                        HStack {
                            ForEach(consonantLetters, id: \.self) { letter in
                                Button(letter) {
                                    word += letter
                                }
                                .padding()
                                .frame(maxWidth: 67)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .shadow(radius: 3)
                            }
                        }
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
                    if word.count < 2 {

                    }
                    getDictionary(theWord: word)
                    word = ""
                }
                .padding(10)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 3)

                HStack {
                    Button("Delete") {
                        if !word.isEmpty {
                            word.removeLast()
                        }
                    }
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)

                    Button("Clear") {
                        word = ""
                    }
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)

                }

            }
            .alert("Top Score!", isPresented: $newScore) {
                TextField("Enter name", text: $addedName)

                Button("Save") {
                    if nameDouble() {
                        print("name taken")
                        return
                    }

                    let ref = Database.database().reference()
                    let newRef = ref.child("leaderboard").childByAutoId()

                    newRef.setValue([
                        "name": addedName,
                        "score": points,
                        "mode": gamemode,
                    ])

                    dismiss()
                }
            }
            .onAppear {
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
    func topHundred() -> Bool {
        let filtered = thisPlayer.filter { $0.mode == gamemode }
        let sorted = filtered.sorted { $0.score > $1.score }

        if sorted.count < 100 {
            return true
        }

        return points > sorted.last!.score
    }
    func nameDouble() -> Bool {
        return thisPlayer.contains {
            $0.name.lowercased() == addedName.lowercased()
                && $0.mode == gamemode
        }
    }
    func generateLetters() {
        if gamemode == 1 {
            let shuffledConsonants = consonants.shuffled()
            consonantLetters = Array(shuffledConsonants.prefix(8))

            let shuffledVowels = vowels.shuffled()
            vowelLetters = Array(shuffledVowels.prefix(4))
        } else {
            if gamemode == 2 {
                let shuffledConsonants = consonants.shuffled()
                consonantLetters = Array(shuffledConsonants.prefix(6))

                let shuffledVowels = vowels.shuffled()
                vowelLetters = Array(shuffledVowels.prefix(3))
            } else {
                let shuffledConsonants = consonants.shuffled()
                consonantLetters = Array(shuffledConsonants.prefix(4))

                let shuffledVowels = vowels.shuffled()
                vowelLetters = Array(shuffledVowels.prefix(2))
            }
        }

        word = ""
    }

    func over() {
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
    }

    func alreadyPlayed(wordPlayed: String) {
        if wordsPlayed.contains(wordPlayed) {
            alreadyPlayed = true
        } else {
            points += wordPlayed.count

            over()

            wordsPlayed.append(wordPlayed)
        }
    }

    func getDictionary(theWord: String) {

        let session = URLSession.shared

        let dictionaryURL = URL(
            string:
                "https://dictionaryapi.com/api/v3/references/collegiate/json/\(theWord)?key=587f7e0d-5c50-4769-a331-613f3d481f68"
        )!

        let dataTask = session.dataTask(with: dictionaryURL) {
            (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
                print("Error: \(error)")
            } else {
                if let data = data {
                    //print("\(data)")
                    //print(data)
                    if let jsonObj =
                        (try? JSONSerialization.jsonObject(with: data)
                            as? [NSDictionary])
                    {
                        //print(jsonObj.count)
                        if jsonObj.indices.contains(0) {
                            alreadyPlayed(wordPlayed: theWord)

                            over()
                        } else {
                            notReal = true
                        }

                        //if let y = jsonObj[0]["date"] as? String {
                        //print(y)
                        //}

                    } else {
                        notReal = true
                        //print("Error: unable to convert json object")
                    }
                } else {
                    notReal = true
                    print("Error: did not receive data")
                }
            }
        }
        dataTask.resume()
    }
}
