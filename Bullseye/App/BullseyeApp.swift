//
//  BullseyeApp.swift
//  Bullseye
//
//  Created by Rodrigo Rovaron on 29/05/22.
//

import SwiftUI

@main
struct BullseyeApp: App {
    
    let game = Game()
    
    var body: some Scene {
        WindowGroup {
            ContentView(game: Game())
        }
    }
}
