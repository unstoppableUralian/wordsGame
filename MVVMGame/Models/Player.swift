//
//  Player.swift
//  MVVMGame
//
//  Created by Русинов Евгений on 10.08.2023.
//

import Foundation

struct Player {
    let name: String
    private(set) var score = 0
    
    mutating func add(score: Int) {
        self.score += score
    }
}
