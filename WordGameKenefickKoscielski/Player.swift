//
//  Player.swift
//  WordGameKenefickKoscielski
//
//  Created by ADDISON KENEFICK on 2/26/26.
//

import SwiftData
import Foundation
class Player: Identifiable {
    let id = UUID()
    var name: String
    var score: String
    init(name: String, score: String) {
        self.name = name
        self.score = score
    }
}
