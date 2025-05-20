//
//  Fixture.swift
//  SPORTX
//
//  Created by Omar Abdelaziz on 20/05/2025.
//

struct TeamOrPlayer {
    var key: Int
    var name: String
    var image: String
    var players: [Player]?
    var coachOrCountry: Coach?
}

struct Player {
    let name:String
    let number:String
    let image: String?
}

struct Coach {
    let name: String

}
