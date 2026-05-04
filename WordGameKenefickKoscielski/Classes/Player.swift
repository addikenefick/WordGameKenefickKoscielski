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
    var score: Int
    var key: String = ""
    var mode: Int = 1
    
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    init(snapshot: [String: Any]) {
        self.name = snapshot["name"] as? String ?? ""
        self.score = snapshot["score"] as? Int ?? 0
        self.mode = snapshot["mode"] as? Int ?? 1
    }
}





