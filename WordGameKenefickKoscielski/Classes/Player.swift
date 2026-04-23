//
//  Player.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/26/26.
//
import Foundation
import FirebaseCore
import FirebaseDatabase
class Player: Identifiable {
    var id = UUID()
    var name: String
    var score: String
    var key: String = ""
    init(name: String, score: String) {
        self.name = name
        self.score = score
    }
    init(snapshot: [String: Any]) {
        self.name = snapshot["name"] as? String ?? ""
        self.score = snapshot["score"] as? String ?? ""
    }
}





