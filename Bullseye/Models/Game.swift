//
//  game.swift
//  Bullseye
//
//  Created by Rodrigo Rovaron on 01/06/22.
//

import Foundation

struct LeaderboadEntry {
    let score: Int
    let date: Date
}

struct Game {

    var target = Int.random(in: 1...100)
    var score = 0
    var round = 1
    var leaderboadEntries: [LeaderboadEntry] = []
    
    init(loadTestData: Bool = false) {
        if loadTestData {
            leaderboadEntries.append(LeaderboadEntry(score: 100, date: Date()))
            leaderboadEntries.append(LeaderboadEntry(score: 80, date: Date()))
            leaderboadEntries.append(LeaderboadEntry(score: 200, date: Date()))
            leaderboadEntries.append(LeaderboadEntry(score: 50, date: Date()))
            leaderboadEntries.append(LeaderboadEntry(score: 20, date: Date()))
        }
    }
    func points(sliderValue: Int) -> Int {
        
        let difference = abs(target - sliderValue)
        let bonus: Int
        
        if difference == 0 {
            bonus = 100
        } else if difference <= 2 {
            bonus = 50
        } else {
            bonus = 0
        }
        
        return 100 - difference + bonus
    }
    
    mutating func addToLeaderbord(point: Int) {
        leaderboadEntries.append(LeaderboadEntry(score: point, date: Date()))
        leaderboadEntries.sort { $0.score > $1.score }
    }
    
    mutating func startNewRound(points: Int) {
        score += points
        round += 1
        target = Int.random(in: 1...100)
        
        addToLeaderbord(point: points)
    }
    
    mutating func restart() {
        score = 0
        round = 1
        target = Int.random(in: 1...100)
    }
}
